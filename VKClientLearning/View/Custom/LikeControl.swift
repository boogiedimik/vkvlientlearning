//
//  LikeControl.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 01.11.2020.
//  Copyright © 2020 Dmitry Cherenkov. All rights reserved.
//

import UIKit

@IBDesignable
class LikeControl: UIControl {

    // MARK: - Properties
    
    @IBInspectable
    var isLiked: Bool = false {
        didSet {
            updateLike()
        }
    }
    
    @IBInspectable
    var likesCount: Int = 0 {
        didSet {
            likeCountLabel.text = "\(likesCount)"
        }
    }
    
    @IBInspectable
    var color: UIColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.75) {
        didSet {
            likeButton.tintColor = color
            likeCountLabel.textColor = color
        }
    }
    
    @IBInspectable
    var backgroundStackColor: UIColor = UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 0.75) {
        didSet {
            stackView.backgroundColor = backgroundStackColor
        }
    }
    
    // MARK: - Subviews
    
    lazy var likeButton: UIButton = {
        let likeButton = UIButton()
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = color
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        likeButton.backgroundColor = .clear
        likeButton.contentHorizontalAlignment = .left
        return likeButton
    }()
    
    lazy var likeCountLabel: UILabel = {
        let likeCountLabel = UILabel()
        likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        likeCountLabel.textColor = color
        likeCountLabel.text = "0"
        likeCountLabel.backgroundColor = .clear
        likeCountLabel.textAlignment = .right
        return likeCountLabel
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis =  .horizontal
        stackView.spacing = 2
        stackView.backgroundColor = backgroundStackColor
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.clipsToBounds = true
        return stackView
    }()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        stackView.addArrangedSubview(likeCountLabel)
        stackView.addArrangedSubview(likeButton)
        likeButton.layer.cornerRadius = likeButton.frame.height / 2
    }
    
    // MARK: - Layouts
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.layer.cornerRadius = stackView.frame.height / 2
    }
    
    // MARK: - Actions
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        isLiked.toggle()
        likesCount = isLiked ? likesCount + 1 : likesCount - 1
        sendActions(for: .valueChanged)
        animateLike()
    }
    
    private func updateLike() {
        let imageName = isLiked ? "heart.fill" : "heart"
        likeButton.setImage(UIImage(systemName: imageName), for: .normal)
        if likesCount < 1 { likesCount = 0 }
    }
    
    
    
    func animateLike() {

        UIView.transition(with: likeButton, duration: 0.3, options: .transitionFlipFromLeft, animations: nil)
        
    }


    
}
