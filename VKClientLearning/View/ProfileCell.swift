//
//  ProfileCell.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 16.10.2020.
//  Copyright © 2020 Dmitry Cherenkov. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

    // MARK: Outlets
    
    @IBOutlet weak var friendAvatarImageView: AvatarView!
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var friendCityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //закругляем аватары
        //friendAvatarImageView.layer.cornerRadius = friendAvatarImageView.frame.height / 2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
