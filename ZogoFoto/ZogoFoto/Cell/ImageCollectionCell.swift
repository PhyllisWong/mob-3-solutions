//
//  ImageCollectionCell.swift
//  ZogoFoto
//
//  Created by djchai on 1/18/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//

import UIKit

class ImageCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Register Nib with CollectionView and its reuse identifier
      
    }
    
    func commonInit(_ image: URL) {
        let data = try! Data(contentsOf: image)
        let image = UIImage(data: data)
        
        imageView.image = image
    }
}
