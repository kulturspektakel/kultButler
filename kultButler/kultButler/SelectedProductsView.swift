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
            ForEach(appState.currentOrder) { order in
                HStack {
                    Text(order.name)
                        .fontWeight(.semibold)
                        .truncationMode(.tail)
                        .lineLimit(1)
					Text("\(order.price.string) €")
                        .fontWeight(.semibold)
                        .truncationMode(.tail)
                        .lineLimit(1)
                    Spacer()
                }
            }.onDelete(perform: delete)
        }.frame(alignment: .leading)
        .padding()
        .listStyle(PlainListStyle())
    }

    func delete(at offsets: IndexSet) {
		appState.removeOrders(atOffsets: offsets)
	}
}

struct SelectedProductsView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedProductsView()
    }
}
