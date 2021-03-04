//
//  NewsFeedCell.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 08.11.2020.
//  Copyright © 2020 Dmitry Cherenkov. All rights reserved.
//

import UIKit

class NewsFeedCell: UITableViewCell {
    
    @IBOutlet weak var userAvatarImageView: AvatarView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var photosContainer: UIView!
    @IBOutlet weak var likeControl: LikeControl!

    // MARK: - Setup
    
    private func configureImages(images: [UIImage]) {
        
        photosContainer.isHidden = images.count == 0
        guard  !images.isEmpty else { return }
        
        switch images.count {
        case 1:
            let imageView = createImageView(image: images[0])
            photosContainer.addSubview(imageView)
            pinView(imageView, to: photosContainer)
        case 2:
            
            let leftImageView = createImageView(image: images[0])
            let rightImageView = createImageView(image: images[1])
            let stackView = UIStackView(arrangedSubviews: [leftImageView, rightImageView])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.backgroundColor = .systemBackground
            stackView.spacing = 3
            stackView.axis = .horizontal
            
            photosContainer.addSubview(stackView)
            pinView(stackView, to: photosContainer)

            NSLayoutConstraint.activate([
                leftImageView.widthAnchor.constraint(equalTo: rightImageView.widthAnchor)
            ])

        case 3:
            
            let topLeftImageView = createImageView(image: images[0])
            let topRightImageView = createImageView(image: images[1])
            let topStackView = UIStackView(arrangedSubviews: [topLeftImageView, topRightImageView])
            topStackView.translatesAutoresizingMaskIntoConstraints = false
            topStackView.backgroundColor = .systemBackground
            topStackView.spacing = 3
            topStackView.axis = .horizontal
            
            let bottomImageView = createImageView(image: images[2])
            let bottomStackView = UIStackView(arrangedSubviews: [bottomImageView])
            bottomStackView.translatesAutoresizingMaskIntoConstraints = false
            bottomStackView.backgroundColor = .systemBackground
            bottomStackView.spacing = 3
            bottomStackView.axis = .horizontal
            
            let stackView = UIStackView(arrangedSubviews: [topStackView, bottomImageView])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.backgroundColor = .systemBackground
            stackView.spacing = 3
            stackView.axis = .vertical
            
            photosContainer.addSubview(stackView)
            pinView(stackView, to: photosContainer)
            
            NSLayoutConstraint.activate([
                topLeftImageView.widthAnchor.constraint(equalTo: topRightImageView.widthAnchor),
                topStackView.heightAnchor.constraint(equalTo: bottomImageView.heightAnchor)
            ])
            
            print(#function)
        case 4:
            photosContainer.isHidden = true
            print(#function)
        default:
        break
        }
    }
   
    func configureCell(item: Post) {
        userAvatarImageView.image = item.avatar
        userNameLabel.text = item.fullName
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        postDateLabel.text = dateFormatter.string(from: item.postedDateTime)
        postText.text = item.postText
        likeControl.likesCount = item.likesCount
        likeControl.isLiked = item.isLikedByUser
        if let images = item.images {
            photosContainer.isHidden = false
            configureImages(images: images)
        } else {
            photosContainer.isHidden = true
        }
    }
    
    // MARK: - Helpers
    
    private func createImageView(image: UIImage) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .width, multiplier: 1, constant: 0))
        imageView.backgroundColor = .systemBackground
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
    
    private func pinView(_ view: UIView, to otherView: UIView) {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: otherView.topAnchor),
            view.bottomAnchor.constraint(equalTo: otherView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: otherView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: otherView.trailingAnchor)
        ])
    }

}
