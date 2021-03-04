//
//  NewsFeedPhotoCell.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 09.02.2021.
//  Copyright © 2021 Dmitry Cherenkov. All rights reserved.
//

import UIKit

class NewsFeedPhotoCell: UITableViewCell, NewsFeedCellConfigurable {
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        subviews.forEach({ $0.removeFromSuperview() })
        layoutIfNeeded()
    }
    
    // MARK: - Functions
    
    func configureCell(item: NewsFeedSample) {
        configureImages(images: item.photos)
    }
    
    private func configureImages(images: [UIImage]) {
        
        guard  !images.isEmpty else { return }
        let imageViews = createImageViews(images: images)
        
        switch images.count {
        
        case 1:
            
            self.addSubview(imageViews[0])
            pinView(imageViews[0], to: self)
            
        case 2:

            let stackView = UIStackView(arrangedSubviews: [imageViews[0], imageViews[1]])
            configureStackView(stackView: stackView, axis: .horizontal)
            self.addSubview(stackView)
            pinView(stackView, to: self)

            NSLayoutConstraint.activate([
                stackView.heightAnchor.constraint(equalTo: imageViews[0].widthAnchor)
            ])

        case 3:
            
            let topStackView = UIStackView(arrangedSubviews: [imageViews[0], imageViews[1]])
            configureStackView(stackView: topStackView, axis: .horizontal)
            let bottomStackView = UIStackView(arrangedSubviews: [imageViews[2]])
            configureStackView(stackView: bottomStackView, axis: .horizontal)
            let stackView = UIStackView(arrangedSubviews: [topStackView, bottomStackView])
            configureStackView(stackView: stackView, axis: .vertical)

            self.addSubview(stackView)
            pinView(stackView, to: self)

            NSLayoutConstraint.activate([
                imageViews[0].widthAnchor.constraint(equalTo: imageViews[1].widthAnchor),
                bottomStackView.heightAnchor.constraint(equalTo: topStackView.heightAnchor)
            ])
            
        case 4:
            
            let topStackView = UIStackView(arrangedSubviews: [imageViews[0], imageViews[1]])
            configureStackView(stackView: topStackView, axis: .horizontal)
            let bottomStackView = UIStackView(arrangedSubviews: [imageViews[2], imageViews[3]])
            configureStackView(stackView: bottomStackView, axis: .horizontal)
            let stackView = UIStackView(arrangedSubviews: [topStackView, bottomStackView])
            configureStackView(stackView: stackView, axis: .vertical)

            self.addSubview(stackView)
            pinView(stackView, to: self)

            NSLayoutConstraint.activate([
                imageViews[0].widthAnchor.constraint(equalTo: imageViews[1].widthAnchor),
                imageViews[2].widthAnchor.constraint(equalTo: imageViews[3].widthAnchor),
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
    
    private func createImageViews(images: [UIImage]) -> [UIImageView] {
        var imageViews = [UIImageView]()
        for item in images {
            let imageView = UIImageView(image: item)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .width, multiplier: 1, constant: 0))
            imageView.backgroundColor = .systemBackground
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = imageView.frame.height * 0.3
            imageViews.append(imageView)
        }
        return imageViews
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



//import UIKit
//
//class NewsFeedPhotoCell: UITableViewCell, NewsFeedCellConfigurable {
//
//    // MARK: - Properties
//
//    lazy var imageViews: [UIImageView] = {
//        var imageViews = [UIImageView]()
//        for _ in 0...3 {
//            let imageView = UIImageView()
//            imageView.translatesAutoresizingMaskIntoConstraints = false
//            imageView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .width, multiplier: 1, constant: 0))
//            imageView.backgroundColor = .systemBackground
//            imageView.contentMode = .scaleAspectFit
//            imageView.clipsToBounds = true
//            imageView.layer.cornerRadius = imageView.frame.height * 0.3
//            imageViews.append(imageView)
//        }
//        return imageViews
//    }()
//
//
//
//    lazy var topStack: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [imageViews[0], imageViews[1]])
//        configureStackView(stackView: stackView, axis: .horizontal)
//        return stackView
//    }()
//
//    lazy var bottomStack: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [imageViews[2], imageViews[3]])
//        configureStackView(stackView: stackView, axis: .horizontal)
//        return stackView
//    }()
//
//    lazy var mainStack: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [topStack, bottomStack])
//        configureStackView(stackView: stackView, axis: .vertical)
//        pinView(stackView, to: self)
//        return stackView
//    }()
////    lazy var bottomStack: UIStackView = {
////        return configureStackView(axis: .horizontal)
////    }()
////
////    lazy var mainStack: UIStackView = {
////        return configureStackView(axis: .vertical)
////    }()
//
//    // MARK: - Life cycle
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
//
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        subviews.forEach({ $0.removeFromSuperview() })
//        clearConstraints()
//        //constraints.forEach({ superview?.removeConstraint($0) })
//        layoutIfNeeded()
//    }
//
//    // MARK: - Functions
//
//    func configureCell(item: NewsFeedSample) {
//        configureImages(images: item.photos)
//    }
//
//    private func configureImages(images: [UIImage]) {
//
//        guard  !images.isEmpty else { return }
//
//        switch images.count {
//
//        case 1:
//            break
////            imageViews[0].image = images[0]
////            mainStack.addArrangedSubview(imageViews[0])
////            self.addSubview(mainStack)
////            pinView(mainStack, to: self)
//
//        case 2:
//
//            //addImagesAndSubviews(images: images)
//            imageViews[0].image = images[0]
//            imageViews[1].image = images[1]
//            self.addSubview(topStack)
//            pinView(topStack, to: self)
//
////            self.addSubview(mainStack)
////            pinView(mainStack, to: self)
//
//            NSLayoutConstraint.activate([
//                imageViews[0].widthAnchor.constraint(equalTo: imageViews[1].widthAnchor)
//            ])
//
//        case 3:
//            break
////            addImagesAndSubviews(images: images)
////            mainStack.addArrangedSubview(topStack)
////            mainStack.addArrangedSubview(bottomStack)
////
////            self.addSubview(mainStack)
////            pinView(mainStack, to: self)
////
////            NSLayoutConstraint.activate([
////                imageViews[0].widthAnchor.constraint(equalTo: imageViews[1].widthAnchor),
////                bottomStack.heightAnchor.constraint(equalTo: topStack.heightAnchor)
////            ])
//
//        case 4:
//
//
//            imageViews[0].image = images[0]
//            imageViews[1].image = images[1]
//            imageViews[2].image = images[2]
//            imageViews[3].image = images[3]
//            self.addSubview(mainStack)
//
//
//            NSLayoutConstraint.activate([
//                imageViews[0].widthAnchor.constraint(equalTo: imageViews[1].widthAnchor),
//                imageViews[0].widthAnchor.constraint(equalTo: imageViews[1].widthAnchor),
//                bottomStack.heightAnchor.constraint(equalTo: topStack.heightAnchor)
//            ])
//
//
//
////            addImagesAndSubviews(images: images)
////            mainStack.addArrangedSubview(topStack)
////            mainStack.addArrangedSubview(bottomStack)
////
////            self.addSubview(mainStack)
////            pinView(mainStack, to: self)
////
////            NSLayoutConstraint.activate([
////                imageViews[0].widthAnchor.constraint(equalTo: imageViews[1].widthAnchor),
////                imageViews[2].widthAnchor.constraint(equalTo: imageViews[3].widthAnchor),
////                bottomStack.heightAnchor.constraint(equalTo: topStack.heightAnchor)
////            ])
//
//        default:
//        break
//        }
//
//    }
//
//    // MARK: - Helpers
//
//    func addImagesAndSubviews(images: [UIImage]) {
//        let indexes = images.count - 1
//        for i in 0...indexes {
//            imageViews[i].image = images[i]
//            if i <= 1 {
//                topStack.addArrangedSubview(imageViews[i])
//            } else {
//                bottomStack.addArrangedSubview(imageViews[i])
//            }
//        }
//    }
//
//    func configureStackView(stackView: UIStackView, axis: NSLayoutConstraint.Axis) {
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.backgroundColor = .systemBackground
//        stackView.spacing = 3
//        stackView.axis = axis
//        //stackView.distribution = .fill
//    }
//
//    private func pinView(_ view: UIView, to otherView: UIView) {
//        NSLayoutConstraint.activate([
//            view.topAnchor.constraint(equalTo: otherView.topAnchor),
//            view.bottomAnchor.constraint(equalTo: otherView.bottomAnchor),
//            view.leadingAnchor.constraint(equalTo: otherView.leadingAnchor),
//            view.trailingAnchor.constraint(equalTo: otherView.trailingAnchor)
//        ])
//    }
//
//}
//
//extension UIView {
//    func clearConstraints() {
//        for subview in self.subviews {
//            subview.clearConstraints()
//        }
//        self.removeConstraints(self.constraints)
//    }
//}
