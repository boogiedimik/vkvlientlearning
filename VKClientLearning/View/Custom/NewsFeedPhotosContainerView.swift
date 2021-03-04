//
//  NewsFeedPhotosContainerView.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 27.02.2021.
//  Copyright © 2021 Dmitry Cherenkov. All rights reserved.
//

import UIKit

class NewsFeedPhotosContainerView: UIView {

    private func configureImages(images: [UIImage]) {
        
        guard  !images.isEmpty else { return }
        
        switch images.count {
        
        case 1:
            let imageView = createImageView(image: images[0])
            self.addSubview(imageView)
            pinView(imageView, to: self)
            
        case 2:
            
            let leftImageView = createImageView(image: images[0])
            let rightImageView = createImageView(image: images[1])
            let stackView = UIStackView(arrangedSubviews: [leftImageView, rightImageView])
            configureStackView(stackView: stackView, axis: .horizontal)
            
            self.addSubview(stackView)
            pinView(stackView, to: self)

            NSLayoutConstraint.activate([
                leftImageView.widthAnchor.constraint(equalTo: rightImageView.widthAnchor)
            ])

        case 3:
            
            let topLeftImageView = createImageView(image: images[0])
            let topRightImageView = createImageView(image: images[1])
            let topStackView = UIStackView(arrangedSubviews: [topLeftImageView, topRightImageView])
            configureStackView(stackView: topStackView, axis: .horizontal)
            let bottomImageView = createImageView(image: images[2])
            let bottomStackView = UIStackView(arrangedSubviews: [bottomImageView])
            configureStackView(stackView: bottomStackView, axis: .horizontal)
            let stackView = UIStackView(arrangedSubviews: [topStackView, bottomStackView])
            configureStackView(stackView: stackView, axis: .vertical)
            
            self.addSubview(stackView)
            pinView(stackView, to: self)
            
            NSLayoutConstraint.activate([
                topLeftImageView.widthAnchor.constraint(equalTo: topRightImageView.widthAnchor),
                topStackView.heightAnchor.constraint(equalTo: bottomImageView.heightAnchor)
            ])
            
        case 4:
            
            let topLeftImageView = createImageView(image: images[0])
            let topRightImageView = createImageView(image: images[1])
            let topStackView = UIStackView(arrangedSubviews: [topLeftImageView, topRightImageView])
            configureStackView(stackView: topStackView, axis: .horizontal)
            let bottomLeftImageView = createImageView(image: images[2])
            let bottomRightImageView = createImageView(image: images[3])
            let bottomStackView = UIStackView(arrangedSubviews: [bottomLeftImageView, bottomRightImageView])
            configureStackView(stackView: bottomStackView, axis: .horizontal)
            let stackView = UIStackView(arrangedSubviews: [topStackView, bottomStackView])
            configureStackView(stackView: stackView, axis: .vertical)
            
            self.addSubview(stackView)
            pinView(stackView, to: self)
            
            NSLayoutConstraint.activate([
                topLeftImageView.widthAnchor.constraint(equalTo: topRightImageView.widthAnchor),
                topStackView.heightAnchor.constraint(equalTo: bottomStackView.heightAnchor)
            ])

        default:
        break
            
        }
    }
   
    
    // MARK: - Helpers
    
    private func configureStackView(stackView: UIStackView, axis: NSLayoutConstraint.Axis) {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemBackground
        stackView.spacing = 3
        stackView.axis = axis
    }
    
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
