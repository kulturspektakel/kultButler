//
//  ProductView.swift
//  kultButler
//
//  Created by Tristan Häuser on 13.04.21.
//

import SwiftUI

struct ProductView: View {
    
    @EnvironmentObject var appState: AppState
    
    var products = [Product]()
    
    init (products: [Product]) {
        self.products = products
    }
    
    let gridItemWidth = (UIScreen.main.bounds.width / 3) * 0.22
    let gridSpacingWidth = (UIScreen.main.bounds.width / 3) * 0.05
    
    var colums: [GridItem] = Array(repeating: .init(.fixed((UIScreen.main.bounds.width / 3) * 0.22 + (((UIScreen.main.bounds.width / 3) * 0.22) / 5) * 2), spacing: (UIScreen.main.bounds.width / 3) * 0.05), count: 5)
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                LazyVGrid(columns: colums, alignment: .leading, spacing: gridSpacingWidth) {
                    ForEach(products) { product in
                        VStack {
                            // swiftlint:disable:next multiple_closures_with_trailing_closure
                            Button( action: { appState.addOrder(order: product) }) {
                                VStack {
                                    Text(product.name)
                                        .fontWeight(.semibold)
                                        .truncationMode(.tail)
                                        .lineLimit(1)
                                    Text("")
                                    Text("\(priceAsDouble(price: product.price), specifier: "%.2f") €")
                                }.frame(width: gridItemWidth, height: gridItemWidth, alignment: .center)
                                .padding((gridItemWidth / 5))
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(gridItemWidth / 4.5)
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    
    func priceAsDouble(price: Int) -> Double { (Double(price) / 100.0) }
}
struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        let products = [Product(name: "Fleischlappen", price: 400)]
        ProductView(products: products)
    }
}
