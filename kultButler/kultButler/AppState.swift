//
//  AppState.swift
//  kultButler
//
//  Created by Gabriel Knoll on 15.04.21.
//

import Combine
import Foundation
import SwiftUI

class AppState: ObservableObject {
    @Published private(set) var lists = [ProducListsQuery.Data.ProductList]()
    @Published var deposit = 0
    @Published private(set) var currentOrder = [
        (Int, [(Int, ProducListsQuery.Data.ProductList.Product)])
    ]()
    @Published private(set) var isCreatingOrder = false
    @Published private(set) var order: CreateOrderMutation.Data.CreateOrder? = nil
    @Published private(set) var connectedPrinter: Printer? = nil
    @Published private(set) var printers = [String: Printer]()
    @Published private(set) var clientId = AppState.generateClientId()
    
    private var printerSdk = PrinterSDK()
    
    
    init() {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.printerDisconnected),
            name: NSNotification.Name.PrinterDisconnected,
            object: nil
        )
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.scanPrinters()
        }
        
        Network.shared.apollo
            .fetch(query: ProducListsQuery(), cachePolicy: .returnCacheDataAndFetch) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let graphQLResult):
                    guard let results = graphQLResult.data else {
                        assertionFailure("Couldn't load ProductList")
                        return
                    }
                    self.lists = results.productLists
                    print("Loaded ProductList succesfully")
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
            }
    }
    
    public func scanPrinters() {
        self.printers.removeAll()
        self.printerSdk.disconnect()
        self.printerSdk.stopScanPrinters()
        
        
        printerSdk.scanPrinters(completion: { printer in
            if let p = printer {
                self.printers[p.uuidString] = p
                if let defaultPrinter = UserDefaults.standard.string(forKey: "printer"), defaultPrinter == p.uuidString {
                    self.connectPrinter(uuid: p.uuidString)
                }
            }
        })
    }
    
    public func connectPrinter(uuid: String!) {
        if let p = self.printers.first(where: { $0.value.uuidString == uuid}) {
            printerSdk.connectBT(p.value)
            self.connectedPrinter = p.value
            UserDefaults.standard.setValue(p.key, forKey: "printer")
        }
    }
    
    @objc private func printerDisconnected(p: Printer) {
        self.connectedPrinter = nil
        printerSdk.stopScanPrinters()
        self.printers = [:]
    }
    
    public func addOrder(listId: Int, order: ProducListsQuery.Data.ProductList.Product) {
        if let i = currentOrder.firstIndex(where: { $0.0 == listId }) {
            var orders = currentOrder[i]
            if let j = orders.1.firstIndex(where: { $0.1.id == order.id }) {
                orders.1[j] = (orders.1[j].0 + 1, orders.1[j].1)
            } else {
                orders.1.append((1, order))
            }
            currentOrder[i] = orders
        } else {
            currentOrder.append((listId, [(1, order)]))
        }
        
        if order.requiresDeposit {
            deposit += 1
        }
    }
    
    public func removeOrders(listId: Int, atOffsets: IndexSet) {
        if let i = currentOrder.firstIndex(where: { $0.0 == listId }) {
            currentOrder[i].1.remove(atOffsets: atOffsets)
            if currentOrder[i].1.isEmpty {
                currentOrder.remove(at: i)
            } else {
                currentOrder[i] = currentOrder[i]
            }
        }
    }
    
    public func resetCurrentOrder() {
        currentOrder = []
        deposit = 0
        clientId = AppState.generateClientId()
        self.resetOnlineOrder()
    }
    
    public func resetOnlineOrder() {
        isCreatingOrder = false
        order = nil
    }
    
    public func currentTotal() -> Int {
        return currentOrder.flatMap({ $0.1 }).reduce(0, { acc, order in
            acc + order.1.price * order.0
        }) + deposit * 200
    }
    
    private static func generateClientId() -> String {
        return String((0..<8).map{ _ in "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".randomElement()! })
    }
    
    public func submitOrder(paymentMethod: OrderPayment) {
        if (self.isCreatingOrder) {
            return;
        }
        self.isCreatingOrder = true
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        let mutation = CreateOrderMutation(
            products: self.currentOrder.flatMap({ (listId, products) in
                products.map({ p in
                    OrderItemInput(
                        perUnitPrice: p.1.price,
                        name: p.1.name,
                        amount: p.0,
                        listId: listId
                    )
                })
            }),
            payment: paymentMethod,
            deposit: self.deposit,
            clientId: clientId,
            deviceTime: dateFormatter.string(from: Date())
        )
        
        Network.shared.apollo.perform(mutation: mutation) { result in
            switch result {
            case .success(let graphQLResult):
                self.order = graphQLResult.data?.createOrder
            case .failure( _):
                self.order = nil
            }
            
            self.isCreatingOrder = false
            self.printOrder()
            
            if
                self.order == nil,
                let val = mutation.variables?.description,
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            {
                do {
                    try String(val).write(
                        to: documentsURL.appendingPathComponent("\(self.clientId).txt"),
                        atomically: true,
                        encoding: .utf8
                    )
                } catch {}
            }
        }
    }
    
    private let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .currency
        nf.alwaysShowsDecimalSeparator = true
        nf.currencyDecimalSeparator = ","
        nf.currencyGroupingSeparator = ""
        nf.currencySymbol = ""
        return nf
    }()
    
    public func printOrder() {
        printerSdk.setFontSizeMultiple(1)
        printerSdk.printText(" KULTURSPEKTAKEL\n  GAUTING 2021")
        
        printerSdk.setFontSizeMultiple(0)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYY HH:mm"
        
        var number = self.clientId
        if let id = self.order?.id {
            number = "#\(id)"
        }
        
        printerSdk.printText("Bestellung \(number)\n\(dateFormatter.string(from: Date()))")
        
        self.currentOrder.forEach({ listId, products in
            let list = self.lists.first(where: { $0.id == listId })
            printerSdk.setFontSizeMultiple(1)
            let listName = String(list?.name
                                    .folding(options: .diacriticInsensitive, locale: .current)
                                    .replacingOccurrences(of: "ß", with: "ss")
                                    .prefix(16) ?? "")
            
            printerSdk.printText(listName)
            printerSdk.setFontSizeMultiple(0)
            
            products.forEach({ p in
                let amount = "\(p.0)x "
                let price = self.numberFormatter.string(
                    from: NSNumber(value: p.1.price * p.0 / 100)
                )?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "0,00"
                let name = p.1.name.folding(options: .diacriticInsensitive, locale: .current).replacingOccurrences(of: "ß", with: "ss")
                let length = amount.count + price.count + name.count
                let fill = String.init(repeating: " ", count: 32 - (length % 32))
                printerSdk.printText("\(amount)\(name)\(fill)\(price)")
            })
        })
        
        if (deposit > 0) {
            printerSdk.printText("\(String.init(repeating: "*", count: 32))\n\(deposit)x Pfand\n\(String.init(repeating: "*", count: 32))")
        }
        
        printerSdk.printText("")
        printerSdk.printText("")
    }
}

