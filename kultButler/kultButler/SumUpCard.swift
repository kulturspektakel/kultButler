//
//  CardReaderCheckoutView.swift
//  kultButler
//
//  Created by Valentin Langer on 16.04.21.
//

import SumUpSDK
import SwiftUI

struct SumUpCard: UIViewControllerRepresentable {
    var total: Int
    var callback: (_ error: String?) -> Void
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let view = CardReaderCheckoutView()
        view.total = self.total
        view.callback = self.callback
        return view
    }
}

class CardReaderCheckoutView: UIViewController {
    var total: Int = 0
    var callback: ((_ error: String?) -> Void)?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if SumUpSDK.isLoggedIn {
            self.doTransaction(total: self.total)
        } else {
            SumUpSDK.presentLogin(from: self, animated: true, completionBlock: { success, error in
                if let e = error {
                    print(e)
                } else {
                    self.navigationController?.popToRootViewController(animated: true)
                    self.doTransaction(total: self.total)
                }
            })
        }
    }
    
    private func doTransaction(total: Int) {
        guard let merchantCurrencyCode = SumUpSDK.currentMerchant?.currencyCode else {
            print("not logged in")
            return
        }
        
        let total = NSDecimalNumber(floatLiteral: Double(total) / 100)
        guard total != NSDecimalNumber.zero else {
            return
        }
        
        // setup payment request
        let request = CheckoutRequest(total: total,
                                      title: "Bestellung",
                                      currencyCode: merchantCurrencyCode)
        
        request.skipScreenOptions = .success
        
        SumUpSDK.checkout(with: request, from: self) { [weak self] (result: CheckoutResult?, error: Error?) in
            if let e = error {
                self?.callback!(e.localizedDescription)
            } else if let r = result, r.success {
                self?.callback!(nil)
            }
            
            self!.navigationController?.popToRootViewController(animated: true)
        }
    }
}
