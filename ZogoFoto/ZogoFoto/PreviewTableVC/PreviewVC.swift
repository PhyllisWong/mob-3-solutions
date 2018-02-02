//
//  PreviewVC.swift
//  ZogoFoto
//
//  Created by djchai on 1/18/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//  Networking Code Credit: Elmer Astudillo

import UIKit

class PreviewVC: UIViewController {
    
   
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var imageCollections = [ImageCollection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        
        // Create UINib for TableViewCell
        // Register Nib with TableView and its reuse identifier
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "tableViewCell")

        // Do any additional setup after loading the view.
        Networking.fetchRequest(url: "https://s3-us-west-2.amazonaws.com/mob3/image_collection.json") { (data) in
            if let imageArray = try? JSONDecoder().decode([ImageCollection].self, from: data) {
                
                DispatchQueue.main.async {
                    self.imageCollections = imageArray
                    
                    // This allows the dispatch queue to controll the threads
                    let dispatchGroup = DispatchGroup()
                    
                    self.unzip(dispatchGroup: dispatchGroup)
                    
                    dispatchGroup.notify(queue: .main, execute: {
                        self.extractPreview()
                        self.tableView.reloadData()
                    })
                }
                
            } else { print("NOPE") }

        }
    }

    func unzip(dispatchGroup: DispatchGroup)  {
        for i in 0..<self.imageCollections.count {
//            print(self.imageCollections[i].zippedImagesUrl)
            dispatchGroup.enter()
            Networking.downloadRequest(
                imageCollection: self.imageCollections[i],
                completion: { cachesURL in
                    
                    // 1. Get folder name
                    let folderName = self.imageCollections[i].zippedImagesUrl.deletingPathExtension().lastPathComponent
                    // Replace occurences of + with " "
                    let sanitizedFolderName = folderName.replacingOccurrences(of: "+", with: " ")
                    let fullUrl = cachesURL.appendingPathComponent(sanitizedFolderName)
                    
                    // Update unzipped folder url
                    self.imageCollections[i].unzippedFolderURL = fullUrl
                    print(self.imageCollections)
                    dispatchGroup.leave()
            })
        }

    }
    
    func extractPreview()  {

        for i in 0..<self.imageCollections.count {
            if let unzippedURL = self.imageCollections[i].unzippedFolderURL {
                guard let previewImage = try! FileManager.default.contentsOfDirectory(at: unzippedURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                    .filter({ (url) -> Bool in
                    url.deletingPathExtension().lastPathComponent == "_preview"
                }).first else {return}
 
                self.imageCollections[i].previewImage = previewImage
            } else {
                print("nil found when trying to get unzipped URL")
            }
        }
        
    }
}

extension PreviewVC: UITableViewDataSource, UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imageCollections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let collection = self.imageCollections[row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        
//        cell.textLabel?.text = collection.collectionName
        cell.commonInit(collection.previewImage!, title: collection.collectionName)
//        cell.cellViewModel = (collection.previewImage!, title: collection.collectionName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let collection = self.imageCollections[row]
        print(collection)

        // Create UINib for CollectionViewCell
        
        let collectionVC = CollectionVC(nibName: "CollectionVC", bundle: Bundle.main)
        // 1. set collectionVC imagecollection(1) to selected collection
        collectionVC.imageCollection = collection
        
        self.navigationController?.pushViewController(collectionVC, animated: true)
    }
}










