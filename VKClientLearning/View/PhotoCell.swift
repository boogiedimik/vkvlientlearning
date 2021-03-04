//
//  PhotoCell.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 19.10.2020.
//  Copyright © 2020 Dmitry Cherenkov. All rights reserved.
//

import UIKit



class PhotoCell: UICollectionViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var likeControl: LikeControl!
    
    var likeButtonAction: (() -> ())?
    
    // MARK: - Livecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoImageView.layer.cornerRadius = photoImageView.frame.height / 10
        photoImageView.clipsToBounds = true
        likeControl.addTarget(self.likeControl.likeButton, action: #selector(likeButtonTapped(_: )), for: .touchUpInside)
    }
        
    @IBAction func likeButtonTapped(_ sender: LikeControl) {
            likeButtonAction?()
        }
    
}




