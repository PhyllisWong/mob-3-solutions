//
//  ViewController.swift
//  ZogoFoto
//
//  Created by Phyllis Wong on 1/17/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//

import UIKit


class HomeScreenVC: UIViewController {
    
    var imageCollections = [ImageCollection]()

    
    
    @IBAction func previewWasPressed(_ sender: UIButton) {
        // Navigate to a custom xib view with a tableview
      
        let previewVC = PreviewVC(nibName: "PreviewVC", bundle: Bundle.main)
        self.present(previewVC, animated:true, completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Create an instance of UIViewController, and then use navigationController to push by name
}

