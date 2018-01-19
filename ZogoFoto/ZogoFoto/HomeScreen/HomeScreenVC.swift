//
//  ViewController.swift
//  ZogoFoto
//
//  Created by Phyllis Wong on 1/17/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//

import UIKit
import Zip
import Alamofire

class HomeScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        makeGETRequest()
    }
    
    func makeGETRequest() {
        request("https://s3-us-west-2.amazonaws.com/mob3/image_collection.json").responseJSON { (response) in
            if let JSON = response.result.value {
                print(JSON)
//                var jsonobject = JSON as! [String : AnyObject]
//                let origin = jsonobject["origin"] as! String
//                let url = jsonobject["url"] as! String
//                print("JSON: \(jsonobject)\n")
//                print("IP Adress origin: \(origin)\n")
//                print("URL of Request: \(url)")
            }
        }
    }
    
    // Create an instance of UIViewController, and then use navigationController to push by name
}

