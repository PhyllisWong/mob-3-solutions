//
//  PreviewVC.swift
//  ZogoFoto
//
//  Created by djchai on 1/18/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//  Code credit: Elmer Astudillo

import UIKit

class PreviewVC: UIViewController {
    
   
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var imageCollections = [ImageCollection]()
    
    override init() {
        
        super.init()
        commonInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("PreviewVC", owner: self, options: nil)
        self.view.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
        Networking.fetchRequest(url: "https://s3-us-west-2.amazonaws.com/mob3/image_collection.json") { (data) in
            if let imageArray = try? JSONDecoder().decode([ImageCollection].self, from: data) {
                self.imageCollections = imageArray
            } else { print("BAD CODE!") }
            
            for i in 0..<self.imageCollections.count {
                print(self.imageCollections[i].zippedImagesUrl)
                Networking.downloadRequest(url: self.imageCollections[i].zippedImagesUrl, completion: { (url) in
                    var path = url
                    if self.imageCollections[i].collectionName == "Forests" {
                        path?.append(contentsOf: "/forest")
                        guard let newPath = path else {return}
                        let pathURL = URL(string: newPath)
                        // Getting the contents of the directory specifically anything with a path extnesion png
                        // Using subcript to get the first value
                        // Getting the thumbail by filtering
                        
                        let directory = try? FileManager.default.contentsOfDirectory(at: pathURL!, includingPropertiesForKeys: nil, options: []).filter{$0.pathExtension == "png"}[0]
                        let galleryDirectory = try? FileManager.default.contentsOfDirectory(at: pathURL!, includingPropertiesForKeys: nil, options: []).filter{$0.pathExtension == "jpeg" || $0.pathExtension == "jpg"}
                        guard let galleryDir = galleryDirectory else {return}
                        guard let trueDirectory = directory else {return}
                        self.imageCollections[i].thumbnail = String(describing:trueDirectory)
                        self.imageCollections[i].previewImage = galleryDir
                        
                        print(self.imageCollections[i].previewImage!)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                })
            }
        }
    }

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
        
        // FIXME: how do I register a xib?
        // let imageCollectionsView =
    }
}










