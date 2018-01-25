//
//  TableViewCell.swift
//  ZogoFoto
//
//  Created by djchai on 1/18/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func commonInit(_ imageName: URL, title: String) {
        let data = try! Data(contentsOf: imageName)
        let image = UIImage(data: data)

        previewImage.image = image
        titleLabel.text = title
    }
    
}
