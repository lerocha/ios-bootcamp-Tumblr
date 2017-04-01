//
//  PhotoCell.swift
//  Tumblr
//
//  Created by Luis Rocha on 3/31/17.
//  Copyright © 2017 Luis Rocha. All rights reserved.
//

import UIKit

class PhotoCell : UITableViewCell {
    
    @IBOutlet weak var blogNameLabel: UILabel!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
