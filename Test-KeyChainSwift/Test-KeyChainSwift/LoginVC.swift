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
    
    
    // User presses the signup button
    @IBAction func didPressSignup(_ sender: UIButton) {
        let user = User(username: usernameTF.text!, password: passwordTF.text!)
        
        Networking.fetch(route: Route.userSignup(user: user)) { (data, res) in
            if res == 200 {
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC")
                
                DispatchQueue.main.async {
                    let appDelegate = UIApplication.shared.delegate!
                    appDelegate.window??.rootViewController = loginVC
                    appDelegate.window??.makeKeyAndVisible()
                }
            } else {
                DispatchQueue.main.async {
                    self.present(AlertViewController.showSignupAlert(), animated: true, completion: nil)
                }
            }
        }
    }
    
    // User pressed the Login button
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
            } else {
                DispatchQueue.main.async {
                    self.present(AlertViewController.showAlert(), animated: true, completion: nil)
                }
            }
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

