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
    var colums : [GridItem] = Array(repeating: .init(.flexible()), count: 5)
    var body: some View {
        ScrollView(.vertical){
            LazyVGrid(columns: colums, alignment: .leading, spacing: 20.0){
                ForEach(products) { product in
                    VStack {
                        Button (action: { print(product.name) })
                        {VStack{

                            Text(product.name).fontWeight(.semibold).truncationMode(.tail)
                            Text("")
                            Text(String(Double(product.price)/100)+"0€")
                            
                        }
                        }
                        .frame(minWidth: 100, maxWidth: 100, minHeight: 100, maxHeight:100, alignment:.center)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(20)
                    }
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
