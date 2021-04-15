//
//  Network.swift
//  kultButler
//
//  Created by Gabriel Knoll on 12.04.21.
//

import Apollo
import Foundation

class Network: ObservableObject {
	static let shared = Network()

	//swiftlint:disable:next force_unwrapping
	private(set) lazy var apollo = ApolloClient(url: URL(string: "https://api.kulturspektakel.de/graphql")!)

	@Published var booths = [Booth]()

	public func loadProducts() {
		Network.shared.apollo
			.fetch(query: ProducListsQuery()) { [weak self] result in
				guard let self = self else { return }

				switch result {
				case .success(let graphQLResult):
					guard let results = graphQLResult.data else {
						assertionFailure("Couldn't load ProductList")
						return
					}
					results.productLists.forEach { booth in
						let products = booth.product.map { product in
							Product(name: product.name, price: product.price)
						}
						let newBooth = Booth(name: booth.name,
											 emoji: booth.emoji,
											 products: products)
						self.booths.append(newBooth)
					}
					print("Loaded ProductList succesfully")
				case .failure(let error):
					fatalError(error.localizedDescription)
				}
			}
	}
}

public struct Booth: Identifiable, Hashable {
	public let id = UUID()
	public let name: String
	public let emoji: String?
	public let products: [Product]
}

public struct Product: Identifiable, Hashable {
	public let id = UUID()
	public let name: String
	public let price: Int
}
