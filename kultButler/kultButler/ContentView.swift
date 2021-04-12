//
//  ContentView.swift
//  kultButler
//
//  Created by Gabriel Knoll on 12.04.21.
//

import SwiftUI

struct ContentView: View {
	@StateObject var network = Network.shared

	var body: some View {
		HStack(alignment: .top, spacing: 20) {
			Divider()
			VStack(alignment: .leading, spacing: 20) {
				Text("Produktauswahl").font(Font.system(.largeTitle))
				List {
					ForEach(network.booths) { booth in
						Text((booth.emoji ?? "") + " " + booth.name)
						ProductView(products: booth.products)
					}
				}.listStyle(PlainListStyle())
			}
			Divider()
			VStack(alignment: .leading) {
				Text("Bestellung").font(Font.system(.largeTitle))
				List {
					Text("Produkt 1")
					Text("Produkt 2")
					Button("Bezahlen", action: { print("OK") })
				}
				.listStyle(SidebarListStyle())
				.frame(minWidth: 0,
					   maxWidth: UIScreen.main.bounds.width / 3,
					   minHeight: 0,
					   maxHeight: .infinity)
			}
		}.onAppear(perform: network.loadProducts)
	}
}

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

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
