//
//  TransitionViewController.swift
//  kultButler
//
//  Created by Valentin Langer on 15.04.21.
//

import SumUpSDK
import UIKit

class TransitionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		SumUpSDK.presentLogin(from: self, animated: true, completionBlock: { _, _ in
			self.navigationController?.popViewController(animated: true)
		})
	}
}
