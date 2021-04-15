//
//  PayMethodsView.swift
//  kultButler
//
//  Created by Valentin Langer on 14.04.21.
//

import SumUpSDK
import SwiftUI

struct PayMethodsView: View {
	@State private var showSumUpSDK = false
    @State private var showSumUpCard = false
	@State private var paymentInfo = ""
	@State private var barButtonDisable = false
	@State private var karteDisableButton = false
	@State private var gutscheinDisableButton = false
	@State private var orgaDisableButton = false
	var body: some View {
		VStack {
			Spacer()
			Text("Bezahlmethoden: ")
				.bold()
				.font(.title)
			Text(paymentInfo)
			HStack {
				Button(action: {
					self.paymentInfo = "Bar Zahlung"
				}) { Text("Bar")
					.frame(width: 150, height: 75)
					.padding()
					.background(Color.gray)
					.foregroundColor(.white)
					.cornerRadius(10.0)
					.disabled(barButtonDisable)
				}
                NavigationLink(destination: SumUpCard(), isActive: $showSumUpCard) {
                    Button(action: {
                        self.showSumUpCard = true
                        self.paymentInfo = "Karten Zahlung"
				}) { Text("Karte")
					.frame(width: 150, height: 75)
					.padding()
					.background(Color.gray)
					.foregroundColor(.white)
					.cornerRadius(10.0)
					.disabled(barButtonDisable)
                    }
				}
				Button(action: {
					self.paymentInfo = "Gutschein Zahlung"
				}) { Text("Gutschein")
					.frame(width: 150, height: 75)
					.padding()
					.background(Color.gray)
					.foregroundColor(.white)
					.cornerRadius(10.0)
					.disabled(barButtonDisable)
				}
				Button(action: {
					self.paymentInfo = "Orga Zahlung"
				}) { Text("Orga")
					.frame(width: 150, height: 75)
					.padding()
					.background(Color.gray)
					.foregroundColor(.white)
					.cornerRadius(10.0)
					.disabled(barButtonDisable)
				}
			}
			Spacer()
			NavigationLink(destination: SumUpView(), isActive: $showSumUpSDK) {
				Button(action: {
					self.showSumUpSDK = true
				}) { Text("Login")
					.frame(width: 150, height: 75)
					.padding()
					.background(Color.gray)
					.foregroundColor(.white)
					.cornerRadius(10.0)
					.disabled(barButtonDisable)
				}
			}
			Spacer()
		}
	}
}

func sumuppayment(total: Double) {
    
    
 
}
    
struct SumUpCard: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}

    func makeUIViewController(context: Context) -> some UIViewController {
        CardReaderCheckoutView()
    }
}


struct SumUpView: UIViewControllerRepresentable {
	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}

	func makeUIViewController(context: Context) -> some UIViewController {
		TransitionViewController()
	}
}

struct PayMethodsView_Previews: PreviewProvider {
	static var previews: some View {
		PayMethodsView()
	}
}
