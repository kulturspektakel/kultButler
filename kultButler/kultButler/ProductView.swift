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
    .background(Color.white)
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
}

struct ProductView: View {
    
    @EnvironmentObject var appState: AppState
    
    private var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10, pinnedViews: [.sectionHeaders]) {
            ForEach(appState.booths) { booth in
                Section(header: categoryVHeader(with: "\(booth.emoji ?? "") \(booth.name)")) {
                    ForEach(booth.products) { product in
                        Button( action: { appState.addOrder(order: product) }) {
                            VStack {
                                Text(product.name)
                                    .fontWeight(.semibold)
                                    .lineLimit(3)
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom, 1)
                                Text("\(product.price.string) €")
                            }
                            .padding(10)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(Color(.label))
                            .background(Color(.systemGray6))
                            .cornerRadius(10.0)
                        }
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
