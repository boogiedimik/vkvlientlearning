//
//  UserGroupsCell.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 22.10.2020.
//  Copyright © 2020 Dmitry Cherenkov. All rights reserved.
//

import UIKit

class UserGroupsCell: UITableViewCell {

    @IBOutlet weak var groupAvatarImageView: AvatarView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var unsubscribeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //groupAvatarImageView.layer.cornerRadius = groupAvatarImageView.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
