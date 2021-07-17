//
//  ContentView.swift
//  kultButler
//
//  Created by Gabriel Knoll on 12.04.21.
//

import SwiftUI

struct CompleteOrder: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.presentationMode) private var presentationMode
    
    var paymentMethod: OrderPayment
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            let icon = Image(systemName: "checkmark.circle")
                .foregroundColor(.green)
                .font(.system(size: 60))
                .padding()
            
            let buttons = VStack(alignment: .center, spacing: 10) {
                Button("Neue Bestellung") {
                    appState.resetCurrentOrder()
                    self.presentationMode.wrappedValue.dismiss()
                }
                .buttonStyle(SolidButton(color: .blue))
                Button("Nochmal Drucken") {
                    appState.printOrder()
                }
                .buttonStyle(SolidButton())
            }
            .padding()
            
            if (appState.isCreatingOrder) {
                ProgressView()
            } else if let order = appState.order {
                icon
                Text("Bestellung #\(order.id)").font(.title)
                buttons
            } else if paymentMethod == .sumUp {
                SumUpCard(total: appState.currentTotal(), callback: { error in
                    if let e = error {
                        print(e)
                    } else {
                        appState.submitOrder(paymentMethod: paymentMethod)
                    }
                })
            } else {
                icon
                Text("Bestellung \(appState.clientId)").font(.title)
                Text("Bestellung konnte nicht zum Server übertragen werden.")
                buttons
            }
        }
        .onDisappear(perform: {
            self.appState.resetOnlineOrder()
        })
        .onAppear(perform: {
            if paymentMethod != .sumUp {
                appState.submitOrder(paymentMethod: paymentMethod)
            }
        })
    }
}
