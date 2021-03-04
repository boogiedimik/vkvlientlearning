//
//  NewsFeedPostCell.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 09.02.2021.
//  Copyright © 2021 Dmitry Cherenkov. All rights reserved.
//

import UIKit

class NewsFeedPostCell: UITableViewCell, NewsFeedCellConfigurable {

    @IBOutlet weak var postTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(item: NewsFeedSample) {
        postTextLabel.text = item.text
    }
    
}
