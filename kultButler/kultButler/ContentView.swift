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
		NavigationView {
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
					VStack {
						Text("Produkt 1")
						Text("Produkt 2")
						NavigationLink(destination: PayMethodsView()) {
							Text("Bezahlen")
                                .frame(width: 200, height: 100)
                                .background(Color.blue)
                                .foregroundColor(.white)
						}.navigationTitle("Navigation")
					}
					.listStyle(SidebarListStyle())
					.frame(minWidth: 0,
						   maxWidth: UIScreen.main.bounds.width / 3,
						   minHeight: 0,
						   maxHeight: .infinity)
				}
			}.onAppear(perform: network.loadProducts)
		}.navigationViewStyle(StackNavigationViewStyle())
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
    }
}
