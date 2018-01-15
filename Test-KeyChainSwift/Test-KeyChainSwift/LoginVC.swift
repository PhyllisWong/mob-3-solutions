//
//  ViewController.swift
//  Test-KeyChainSwift
//
//  Created by djchai on 1/11/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//

import UIKit
import KeychainSwift


class LoginVC: UIViewController {
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    let keychain = KeychainSwift()
    
    var user = UserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.usernameTF.delegate = self
        self.passwordTF.delegate = self
    }
    
    @IBAction func didPressLogin(_ sender: Any) {
        // make the network call here
        let user = User(username: usernameTF.text!, password: passwordTF.text!)
        
        Networking.fetch(route: Route.userLogin(user: user)) { (data, res) in
            // If user has already signed up
            if res == 200 {
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let successVC = storyboard.instantiateViewController(withIdentifier: "SuccessNav")
                
                DispatchQueue.main.async {
                    let appDelegate = UIApplication.shared.delegate!
                    appDelegate.window??.rootViewController = successVC
                    appDelegate.window??.makeKeyAndVisible()
                }
            }
        }
        
    }
    
    struct BasicAuth {
        static func generateBasicAuthHeader(username: String, password: String) -> String {
            let loginString = String(format: "%@:%@", username, password)
            let loginData: Data = loginString.data(using: String.Encoding.utf8)!
            let base64LoginString = loginData.base64EncodedString(options: .init(rawValue: 0))
            let authHeaderString = "Basic \(base64LoginString)"
            
            return authHeaderString
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // hide the keyboard when user touches outside the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

