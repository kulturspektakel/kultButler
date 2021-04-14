//
//  ProductView.swift
//  kultButler
//
//  Created by Tristan Häuser on 13.04.21.
//

import SwiftUI

struct ProductView: View {
    var products = [Product]()

    init(products: [Product]) {
        self.products = products
    }

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 20) {
                ForEach(products) { product in
                    Button(product.name + " " + String(product.price), action: { print("Kaufen") })
                }
            }
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        let products = [Product(name: "Fleischlappen", price: 400)]
        ProductView(products: products)
    }
}
