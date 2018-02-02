//
//  CollectionVC.swift
//  ZogoFoto
//
//  Created by djchai on 1/18/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionVC: UICollectionViewController {
    
    var imageCollection: ImageCollection?

    var imageURLS = [URL]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.delegate = self
        collectionView?.dataSource = self

        
        // 2. An array of all images in imageCollection above, taken from file manager
        // look up file manager . contents of directory will give you an array of URLs
        // which are the urls to all the files in the /forest or /swimming etc.. folder
        let filemanager = FileManager.default
        imageURLS = try! filemanager.contentsOfDirectory(at: imageCollection!.unzippedFolderURL!, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
        
        
        collectionView?.reloadData()
        
        // Register Nib with CollectionView and its reuse identifier
        let nib = UINib(nibName: "ImageCollectionCell", bundle: nil)
        collectionView!.register(nib, forCellWithReuseIdentifier: "imageCollectionCell")
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageURLS.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 300)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCollectionCell", for: indexPath) as! ImageCollectionCell
    
        guard let imageURL = imageCollection?.previewImage else {
            print("Leslie Nope")
            return cell
        }
        
        let imageData = try! Data(contentsOf: imageURL)
        let image = UIImage(data: imageData)
        // Configure the cell
        cell.imageView.image = image
        return cell
    }
}
/*
let row = indexPath.row
let collection = self.imageCollections[row]
let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell

//        cell.textLabel?.text = collection.collectionName
cell.commonInit(collection.previewImage!, title: collection.collectionName)
//        cell.cellViewModel = (collection.previewImage!, title: collection.collectionName)
return cell
 */
