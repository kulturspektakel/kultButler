//
//  ProductView.swift
//  kultButler
//
//  Created by Tristan Häuser on 13.04.21.
//

import SwiftUI

private func categoryVHeader(with header: String) -> some View {
    HStack {
        Text(header)
            .font(.title2)
            .fontWeight(.semibold)
        Spacer()
    }
    .padding(.vertical, 8)
    .background(Color(.systemBackground))
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
}

struct ProductView: View {
    
    @EnvironmentObject var appState: AppState
    
    private var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10, pinnedViews: [.sectionHeaders]) {
            ForEach(appState.lists, id: \.self.id) { list in
                Section(header: categoryVHeader(with: "\(list.emoji ?? "") \(list.name)")) {
                    ForEach(list.product, id: \.self.id) { product in
                        Button( action: { appState.addOrder(listId: list.id, order: product) }) {
                            VStack {
                                Text(product.name)
                                    .fontWeight(.semibold)
                                    .lineLimit(3)
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom, 1)
                                HStack {
                                    PriceLabel(price: product.price)
                                    if product.requiresDeposit {
                                        Deposit()
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }.buttonStyle(SolidButton())
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView()
    }
}
