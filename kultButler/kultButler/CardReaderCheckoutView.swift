//
//  CardReaderCheckoutView.swift
//  kultButler
//
//  Created by Valentin Langer on 16.04.21.
//

import SwiftUI
import SumUpSDK

class CardReaderCheckoutView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showResult(string: String) {
        print(string)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SumUpSDK.presentLogin(from: self, animated: true, completionBlock: { _, _ in
            self.navigationController?.popToRootViewController(animated: true)
        })
        guard let merchantCurrencyCode = SumUpSDK.currentMerchant?.currencyCode else {
            print("not logged in")
            return
        }

        // create an NSDecimalNumber from the totalText
        // please be aware to not use NSDecimalNumber initializers inherited from NSNumber
        let total = NSDecimalNumber(string: "5")
        guard total != NSDecimalNumber.zero else {
            return
        }

        // setup payment request
        let request = CheckoutRequest(total: total,
                                      title: "Bestellung",
                                      currencyCode: merchantCurrencyCode)
        
        SumUpSDK.checkout(with: request, from: self) { [weak self] (result: CheckoutResult?, error: Error?) in
            if let safeError = error as NSError? {
                print("error during checkout: \(safeError)")

                if (safeError.domain == SumUpSDKErrorDomain) && (safeError.code == SumUpSDKError.accountNotLoggedIn.rawValue) {
                    self?.showResult(string: "not logged in")
                } else {
                    self?.showResult(string: "general error")
                }

                return
            }

            guard let safeResult = result else {
                print("no error and no result should not happen")
                return
            }

            print("result_transaction==\(String(describing: safeResult.transactionCode))")

            if safeResult.success {
                print("success")
                var message = "Thank you - \(String(describing: safeResult.transactionCode))"

                if let info = safeResult.additionalInfo,
                    let tipAmount = info["tip_amount"] as? Double, tipAmount > 0,
                    let currencyCode = info["currency"] as? String {
                    message = message.appending("\ntip: \(tipAmount) \(currencyCode)")
                }

                self?.showResult(string: message)
            } else {
                print("cancelled: no error, no success")
                self?.showResult(string: "No charge (cancelled)")
            }
        // after the checkout is initiated we expect a checkout to be in progress
        if !SumUpSDK.checkoutInProgress {
            // something went wrong: checkout was not started
            print("failed to start checkout")
        }
    }
    }
}
