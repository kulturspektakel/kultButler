//
//  ContentView.swift
//  kultButler
//
//  Created by Gabriel Knoll on 12.04.21.
//

import SwiftUI

struct ContentView: View {
	@StateObject var appState = AppState()

	var body: some View {
		NavigationView {
			HStack(alignment: .top, spacing: 20) {
				Divider()
				VStack(alignment: .leading, spacing: 20) {
					Text("Produktauswahl").font(Font.system(.largeTitle))
					List {
						ForEach(appState.booths) { booth in
							Text((booth.emoji ?? "") + " " + booth.name)
							ProductView(products: booth.products)
						}
					}.listStyle(PlainListStyle())
				}
				Divider()

				VStack(alignment: .leading) {
					Text("Bestellung").font(Font.system(.largeTitle))
					VStack {
                        SelectedProductsView()
						Text("Gesamter Bestellwert: \(appState.currentOrderSum, specifier: "%.2f") €")
						Divider()
						HStack {
							Text("Zurücksetzen")
								//swiftlint:disable:next colon
								.frame(width: 200, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
								.background(Color.red)
								.foregroundColor(.white)
								.onTapGesture { appState.resetCurrentOrder() }
							NavigationLink(destination: PayMethodsView()) {
								Text("Bezahlen")
									//swiftlint:disable:next colon
									.frame(width: 200, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
									.background(Color.blue)
									.foregroundColor(.white)
							}.navigationTitle("Start")
						}
					}
					.listStyle(SidebarListStyle())
					.frame(minWidth: 0,
						   maxWidth: UIScreen.main.bounds.width / 3,
						   minHeight: 0,
						   maxHeight: .infinity)
				}
			}
		}
		.navigationViewStyle(StackNavigationViewStyle())
		.environmentObject(appState)
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
    }
}
