//
//  SearchGroupsCell.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 25.10.2020.
//  Copyright © 2020 Dmitry Cherenkov. All rights reserved.
//

import UIKit

class SearchGroupsCell: UITableViewCell {

    // MARK: - Properties and outlets
    
    @IBOutlet weak var groupAvatarImageView: AvatarView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    var addButtonAction: (() -> ())? //опциональный кложур-подписка на
    
    // MARK: - Livecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Actions
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        addButtonAction?()
    }
    
}
