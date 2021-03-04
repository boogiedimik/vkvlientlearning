//
//  AvatarView.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 01.11.2020.
//  Copyright © 2020 Dmitry Cherenkov. All rights reserved.
//

import UIKit


@IBDesignable
class AvatarView: UIView {

    // MARK: - Subviews and properties
    
    lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.clipsToBounds = true
        return avatarImageView
    }()
    
    lazy var shadowView: UIView = {
        let shadowView = UIView()
        shadowView.clipsToBounds = false
        shadowView.backgroundColor = .white
        return shadowView
    }()
    
    lazy var onlineIndicator: UIView = {
        let onlineIndicator = UIView()
        onlineIndicator.backgroundColor = .green
        onlineIndicator.alpha = 0.4
        onlineIndicator.isHidden = true
        return onlineIndicator
    }()
    
    @IBInspectable
    override var contentMode: UIView.ContentMode {
        didSet {
            avatarImageView.contentMode = contentMode
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat = 0 {
        didSet {
            updateShadow()
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor = .black {
        didSet {
            updateShadow()
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float = 1 {
        didSet {
            updateShadow()
        }
    }
    
    @IBInspectable
    var image: UIImage? {
        didSet {
            avatarImageView.image = image
            setNeedsDisplay()
        }
    }
    
    // MARK: - Inints
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Functions
    
    private func setup() {
        addSubview(shadowView)
        addSubview(avatarImageView)
        addSubview(onlineIndicator)
        
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        onlineIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: topAnchor),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor),
            shadowView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: trailingAnchor),
            avatarImageView.topAnchor.constraint(equalTo: topAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            onlineIndicator.bottomAnchor.constraint(equalTo: bottomAnchor),
            onlineIndicator.trailingAnchor.constraint(equalTo: trailingAnchor),
            onlineIndicator.widthAnchor.constraint(equalToConstant: self.frame.width * 0.14),
            onlineIndicator.heightAnchor.constraint(equalToConstant: self.frame.height * 0.14)
        ])
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(animateAvatar(gesture: )))
        self.addGestureRecognizer(tapGesture)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shadowView.layer.cornerRadius = shadowView.frame.height / 2
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        onlineIndicator.layer.cornerRadius = onlineIndicator.frame.height / 2
    }
 
    private func updateShadow() {
        shadowView.layer.shadowRadius = shadowRadius
        shadowView.layer.shadowColor = shadowColor.cgColor
        shadowView.layer.shadowOpacity = shadowOpacity
    }
    
    @objc func animateAvatar(gesture: UITapGestureRecognizer) {
        
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.9
        animation.toValue = 1
        animation.mass = 2
        animation.duration = 2
        self.avatarImageView.layer.add(animation, forKey: nil)

    }
    
}
