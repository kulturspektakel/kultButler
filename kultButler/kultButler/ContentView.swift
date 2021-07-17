//
//  ContentView.swift
//  kultButler
//
//  Created by Gabriel Knoll on 12.04.21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var appState = AppState()
    @State var selectPaymentMethod = false
    @State var selectPrinter = false
    @State var paymentMethod: OrderPayment? = nil
    
    var body: some View {
        let completeOrder = Binding(
            get: { self.paymentMethod != nil },
            set: { _, _ in
                self.paymentMethod = nil
            }
        )
        
        HStack(alignment: .top, spacing: 20) {
            ScrollView {
                ProductView()
            }
            .clipped()
            .padding(.leading, 17)
            
            Divider()
            
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Text("Bestellung")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    Button {
                        appState.scanPrinters()
                        selectPrinter = true
                    } label: {
                        Image(systemName: "printer")
                        Circle()
                            .fill(appState.connectedPrinter != nil ? Color.green : Color.red)
                            .frame(width: 12, height: 12)
                    }
                    .actionSheet(isPresented: $selectPrinter) {
                        ActionSheet(title: Text("Drucker auswählen"), buttons: appState.printers.map({ p in
                            .default(Text("\(p.value.name) \(String(p.key.prefix(6)))")) {
                                appState.connectPrinter(uuid: p.key)
                            }
                        }))
                    }
                }
                .padding()
                
                VStack {
                    SelectedProductsView()
                    Stepper(value: $appState.deposit) {
                        Text("\(appState.deposit)× Pfand").fontWeight(.semibold)
                    }
                    .padding(17)
                    
                    HStack {
                        Text("Summe")
                            .fontWeight(.semibold)
                            .font(.title3)
                        Spacer()
                        PriceLabel(price: appState.currentTotal()).font(.title3)
                    }.padding(.horizontal, 17)
                    Divider()
                    HStack {
                        Button(action: { appState.resetCurrentOrder() }) {
                            Text("Zurücksetzen").frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .buttonStyle(SolidButton(color: .red))
                        Button(action: {
                            selectPaymentMethod = true
                        }, label: {
                            Text("Bezahlen").frame(maxWidth: .infinity, maxHeight: .infinity)
                        })
                        .buttonStyle(SolidButton(color: .blue))
                        .disabled(
                            (appState.currentOrder.isEmpty && appState.deposit == 0) ||
                                appState.connectedPrinter == nil
                        )
                        .actionSheet(
                            isPresented: $selectPaymentMethod,
                            content: {
                                ActionSheet(title: Text("Zahlungsmethode auswählen"), buttons: [
                                    .default(Text("💰 Bar")) {
                                        paymentMethod = .cash
                                    },
                                    .default(Text("💳 Karte")) {
                                        paymentMethod = .sumUp
                                    },
                                    .default(Text("🧑‍✈️ Crew")) {
                                        paymentMethod = .freeCrew
                                    },
                                    .default(Text("👩‍🎤 Band")) {
                                        paymentMethod = .freeBand
                                    },
                                    .default(Text("🎟 Gutschein")) {
                                        paymentMethod = .voucher
                                    },
                                ])
                            })
                        
                    }
                    .frame(height: 70)
                    .padding(17)
                }
                .listStyle(SidebarListStyle())  
            }
            .frame(minWidth: 0,
                   maxWidth: UIScreen.main.bounds.width / 3,
                   minHeight: 0,
                   maxHeight: .infinity)
        }
        .sheet(isPresented: completeOrder) {
            CompleteOrder(paymentMethod: self.paymentMethod ?? .cash)
        }
        .environmentObject(appState)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
