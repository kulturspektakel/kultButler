//
//  AppState.swift
//  kultButler
//
//  Created by Gabriel Knoll on 15.04.21.
//

import Combine
import Foundation
import SwiftUI

class AppState: ObservableObject {
	@Published var booths = [Booth]()
	@Published private(set) var currentOrder = [Product]()

	private var boothLoader: AnyCancellable?

	init() {
		boothLoader = Network.shared.$booths
			.sink(receiveValue: { [weak self] result in
				self?.booths = result
			})
	}

	public func addOrder(order: Product) {
		currentOrder.append(order)
	}

	public func removeOrders(atOffsets: IndexSet) {
		currentOrder.remove(atOffsets: atOffsets)
	}

	public func resetCurrentOrder() {
		currentOrder = []
	}
}
