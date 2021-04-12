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

	@Published var products = [Booth]()
	@Published var description: String = "Please wait"

	public func loadProducts() {
		Network.shared.apollo
			.fetch(query: ProducListsQuery()) { [weak self] result in

				guard let self = self else {
					return
				}

				switch result {
				case .success(let graphQLResult):
					guard let results = graphQLResult.data else {
						fatalError()
					}
					results.productLists.forEach { booth in
						let newBooth = Booth(name: booth.name,
											 emoji: booth.emoji,
											 products: booth.product)
						self.products.append(newBooth)
					}
					self.description = results.productLists.debugDescription
				case .failure(let error):
					fatalError(error.localizedDescription)
				}
			}
	}
}

public struct Booth: Equatable, Identifiable {
	public static func == (lhs: Booth, rhs: Booth) -> Bool {
		lhs.name == rhs.name
	}

	public let id = UUID()
	public let name: String
	public let emoji: String?
	public let products: [ProducListsQuery.Data.ProductList.Product]
}
