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
		VStack {
			Text(network.description)
				.padding()
		}.onAppear(perform: network.loadProducts)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
