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
        //FIXME: add this code
        // Navigate to a custom xib view with a tableview
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PreviewVC") as! PreviewVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 300
        
//        Networking.fetchRequest(url: "https://s3-us-west-2.amazonaws.com/mob3/image_collection.json") { (data) in
//            if let imageArray = try? JSONDecoder().decode([ImageCollection].self, from: data) {
//                self.imageCollections = imageArray
//            } else { print("BAD CODE!") }
//
//            for i in 0..<self.imageCollections.count {
//                print(self.imageCollections[i].collectionName)
//                print(self.imageCollections[i].zippedImagesUrl)
//                Networking.downloadRequest(url: self.imageCollections[i].zippedImagesUrl, completion: { (url) in
//                    var path = url
//                    if self.imageCollections[i].collectionName == "Forests" {
//                        path?.append(contentsOf: "/forest")
//                        guard let newPath = path else {return}
//                        let pathURL = URL(string: newPath)
//                        // Getting the contents of the directory specifically anything with a path extnesion png
//                        // Using subcript to get the first value
//                        // Getting the thumbail by filtering
//
//                        let directory = try? FileManager.default.contentsOfDirectory(at: pathURL!, includingPropertiesForKeys: nil, options: []).filter{$0.pathExtension == "png"}[0]
//                        let galleryDirectory = try? FileManager.default.contentsOfDirectory(at: pathURL!, includingPropertiesForKeys: nil, options: []).filter{$0.pathExtension == "jpeg" || $0.pathExtension == "jpg"}
//                        guard let galleryDir = galleryDirectory else {return}
//                        guard let trueDirectory = directory else {return}
//                        self.imageCollections[i].thumbnail = String(describing:trueDirectory)
//                        self.imageCollections[i].previewImage = galleryDir
//
//                        print(self.imageCollections[i].previewImage!)
//                        DispatchQueue.main.async {
//                            self.viewDidLoad()
//                        }
//                    }
//                })
//            }
//        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // Create an instance of UIViewController, and then use navigationController to push by name
}

