//
//  SelectedProductsView.swift
//  kultButler
//
//  Created by Tristan Häuser on 15.04.21.
//

import SwiftUI

struct SelectedProductsView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        List {
            ForEach(appState.currentOrder, id: \.0) { listId, orders in
                let list = appState.lists.first(where: {$0.id == listId})
                Section(header: Text(list?.name ?? "")) {
                    ForEach(orders, id: \.1.name) { order in
                        HStack {
                            Text("\(order.0 > 1 ? "\(order.0)× " : "")\(order.1.name)")
                                .fontWeight(.semibold)
                                .truncationMode(.tail)
                                .lineLimit(1)
                            Spacer()
                            PriceLabel(price: order.1.price * order.0)
                        }
                    }.onDelete { indexSet in
                        appState.removeOrders(listId: listId, atOffsets: indexSet)
                    }
                }
            }
        }
        .frame(alignment: .leading)
        .listStyle(PlainListStyle())
    }
}

struct SelectedProductsView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedProductsView()
    }
}
