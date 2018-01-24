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
        
//        let tableViewCell = TableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "tableViewCell")
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "tableViewCell")

        // Do any additional setup after loading the view.
        Networking.fetchRequest(url: "https://s3-us-west-2.amazonaws.com/mob3/image_collection.json") { (data) in
            if let imageArray = try? JSONDecoder().decode([ImageCollection].self, from: data) {
                
                DispatchQueue.main.async {
                    self.imageCollections = imageArray
                    self.unzip()
                }
                
            } else { print("BAD CODE!") }

        }
    }

    func unzip()  {
        for i in 0..<self.imageCollections.count {
            print(self.imageCollections[i].zippedImagesUrl)
            
            Networking.downloadRequest(
                imageCollection: self.imageCollections[i],
                completion: { cachesURL in
                    
                    
                    // 1. Get folder name
                    let folderName = self.imageCollections[i].zippedImagesUrl.deletingPathExtension().lastPathComponent
                    let fullUrl = cachesURL.appendingPathComponent(folderName)
                    
                    // Update unzipped folder url
                    self.imageCollections[i].unzippedFolderURL = fullUrl
            })
        }


        print(self.imageCollections)
        self.extractPreview()
    }
    
    func extractPreview()  {
        for i in 0..<self.imageCollections.count {
            guard let previewImage = try! FileManager.default.contentsOfDirectory(at: self.imageCollections[i].unzippedFolderURL!, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                .filter({ (url) -> Bool in
                url.deletingPathExtension().lastPathComponent == "_preview"
            }).first else {return}
            
            self.imageCollections[i].previewImage = previewImage
        }
    }
    // Called when download and unzipping of 1 image is done
    // And returns the caches directory
//    func updateImageCollection(with cachesURL: URL, zippedImageCollection: ImageCollection) -> URL {
//        guard let unzippedFolder = try! FileManager.default.contentsOfDirectory(at: cachesURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
//            .filter({ (url) -> Bool in
//            return !url.lastPathComponent.contains(zippedImageCollection.zippedImagesUrl.lastPathComponent)
//            }).first else {return URL(string: "www.google.com")!}
//
//        return unzippedFolder
//    }
//
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        cell.textLabel?.text = collection.collectionName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let collection = self.imageCollections[row]
        print(collection)

    }
}










