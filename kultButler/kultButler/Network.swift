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

	private(set) lazy var apollo = ApolloClient(url: URL(string: "https://api.kulturspektakel.de/graphql")!)

	@Published var products = [ProducListsQuery.Data.ProductList]()
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
					self.products = results.productLists
					self.description = results.productLists.debugDescription
				case .failure(let error):
					fatalError(error.localizedDescription)
				}
			}
	}
}
