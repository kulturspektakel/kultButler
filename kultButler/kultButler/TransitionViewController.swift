//
//  TransitionViewController.swift
//  kultButler
//
//  Created by Valentin Langer on 15.04.21.
//

import UIKit
import SumUpSDK

class TransitionViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel(frame: CGRect(x: 50, y: 50, width: 50, height: 200))
        label.text = "test"
        view.addSubview(label)
        SumUpSDK.presentLogin(from: self, animated: true, completionBlock: nil)
        // Do any additional setup after loading the view.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
