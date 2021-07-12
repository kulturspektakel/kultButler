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
                ScrollView {
                    ProductView()
                }.padding(.leading, 17)
				Divider()

				VStack(alignment: .leading) {
					Text("Bestellung").font(Font.system(.largeTitle))
					VStack {
                        SelectedProductsView()
                        Stepper(value: $appState.pfand) {
                            Text("\(appState.pfand)x Pfand").fontWeight(.semibold)
                        }.padding(.horizontal, 17)
                        
                        HStack {
                            Text("Summe").fontWeight(.semibold)
                            Spacer()
                            Text("\(appState.currentOrderSum, specifier: "%.2f") €")
                        }.padding(.horizontal, 17)
						Divider()
						HStack {
                            Button(action: { appState.resetCurrentOrder() }) {
                                Text("Zurücksetzen")
                                    .fontWeight(.semibold)
                                    //swiftlint:disable:next colon
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.red)
                            .cornerRadius(10.0)
							NavigationLink(destination: PayMethodsView()) {
								Text("Bezahlen")
                                    .fontWeight(.semibold)
									//swiftlint:disable:next colon
									.foregroundColor(.white)
							}
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10.0)
                        }
                        .padding(.horizontal, 17)
                        .frame(height: 70)
					}
					.listStyle(SidebarListStyle())
					.frame(minWidth: 0,
						   maxWidth: UIScreen.main.bounds.width / 3,
						   minHeight: 0,
						   maxHeight: .infinity)
				}
			}
            .navigationTitle("Produktauswahl")
            .navigationBarHidden(true)
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
