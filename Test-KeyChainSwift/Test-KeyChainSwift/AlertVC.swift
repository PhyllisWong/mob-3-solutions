//
//  AlertVC.swift
//  Test-KeyChainSwift
//
//  Created by Phyllis Wong on 1/15/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//

import UIKit

struct AlertViewController {
    static func showAlert() -> UIAlertController {
        let alertController = UIAlertController(title: "Error", message: "Wrong email / password", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alertController
    }
    
    static func showSignupAlert() -> UIAlertController {
        let alertController = UIAlertController(title: "Error", message: "Sign up for a user account", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alertController
    }
}





