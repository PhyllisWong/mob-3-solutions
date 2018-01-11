//
//  ViewController.swift
//  Test-UserDefaults
//
//  Created by djchai on 1/10/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let movie = Movie(title: "The Fun Guy", leadActor: "Tony Cioara")
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageTF: UITextField!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movieValue = UserDefaults.standard.data(forKey: "movieDataKey") {
            if let movie = NSKeyedUnarchiver.unarchiveObject(with: movieValue) as? Movie {
                messageLabel.text = movie.title
            }
        }
        
        // Get
//        let value = UserDefaults.standard.string(forKey: "messageKey")
//        messageLabel.text = value
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveButton(_ sender: Any) {
        let message = messageTF.text
        
        
        let movieData = NSKeyedArchiver.archivedData(withRootObject: self.movie)
        UserDefaults.standard.set(movieData, forKey: "movieDataKey")
        // Set
//        UserDefaults.standard.set(message, forKey: "messageKey")
        messageLabel.text = message
    }

}

