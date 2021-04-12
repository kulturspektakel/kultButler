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
					ForEach(network.products) { product in
						Text((product.emoji ?? "") + " " + product.name)
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

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
