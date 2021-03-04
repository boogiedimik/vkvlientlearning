//
//  NewsFeedFooterCell.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 09.02.2021.
//  Copyright © 2021 Dmitry Cherenkov. All rights reserved.
//

import UIKit

class NewsFeedFooterCell: UITableViewCell, NewsFeedCellConfigurable {

    // MARK: - Outlets
    
    @IBOutlet weak var likeButton: LikeControl!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var repostCounterLabel: UILabel!
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Functions
    
    func configureCell(item: NewsFeedSample) {
        likeButton.isLiked = item.isLiked
        likeButton.likesCount = item.likesCount
        commentsCountLabel.text = String(item.commentsCount)
        repostCounterLabel.text = String(item.repostCount)
    }
    
}
