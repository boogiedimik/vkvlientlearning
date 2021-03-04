//
//  PhotoCollectionView.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 10.11.2020.
//  Copyright © 2020 Dmitry Cherenkov. All rights reserved.
//

import UIKit

//@IBDesignable
class PhotoCollectionView: UIView {

    // MARK: - Properties
    
    var photos: [UserPhotos] = []
    var photoIndex: Int = 0
    
    private lazy var panRecognizer: UIPanGestureRecognizer = {
        let recognizer = UIPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(imagePanned(recognizer: )))
        return recognizer
    }()
    
    // MARK: - Subviews
    
    lazy var firstPhotoView: UIImageView = {
        return configureImageView()
    }()
    
    lazy var secondPhotoView: UIImageView = {
        return configureImageView()
    }()
    
    lazy var thirdPhotoView: UIImageView = {
        return configureImageView()
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        
        self.backgroundColor = .clear
        
        addSubview(firstPhotoView)
        addSubview(secondPhotoView)
        addSubview(thirdPhotoView)
        
        firstPhotoView.backgroundColor = .green
        secondPhotoView.backgroundColor = .clear
        thirdPhotoView.backgroundColor = .cyan
        
        firstPhotoView.translatesAutoresizingMaskIntoConstraints = false
        secondPhotoView.translatesAutoresizingMaskIntoConstraints = false
        thirdPhotoView.translatesAutoresizingMaskIntoConstraints = false

        makeCenterView(view: firstPhotoView)
        makePreviousView(view: secondPhotoView)
        makeFollowingView(view: thirdPhotoView)
        
        self.addGestureRecognizer(panRecognizer)
    }
    
    // MARK: - Functions
    
    @objc private func imagePanned(recognizer: UIPanGestureRecognizer) {
        
        switch recognizer.state {
        
        case .began:
            print(#function + "began")

            let centerView = secondPhotoView
            let followingView = thirdPhotoView

            followingView.frame = centerView.frame
            followingView.transform = CGAffineTransform(translationX: centerView.frame.width, y: 0)

            UIView.animateKeyframes(withDuration: 0.7, delay: 0, options: [], animations: {

                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.7, animations: {
                    let centerViewTranslation = CGAffineTransform(translationX: -200, y: 0)
                    let centerViewScale = CGAffineTransform(scaleX: 0.7, y: 0.7)
                    centerView.transform = centerViewTranslation.concatenating(centerViewScale)
                    self.bringSubviewToFront(followingView)
                })

                UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.4, animations: {
                    let followingViewTranslation = CGAffineTransform(translationX: centerView.frame.width / 2 , y: 0)
                    let followingViewScale = CGAffineTransform(scaleX: 1.3, y: 1.3)
                    followingView.transform = followingViewTranslation.concatenating(followingViewScale)
                })

                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                    followingView.transform = .identity
                })

            }, completion: { finished in
                if finished {
                    centerView.transform = .identity
                }
            })
            
        case .changed:
            print(#function + "changed")
        case .ended:
            print(#function + "ended")
            
        default:
            break
            
        }
    }
    
    private func makeCenterView(view: UIImageView) {
        self.bringSubviewToFront(view)
        NSLayoutConstraint.activate([
            secondPhotoView.topAnchor.constraint(equalTo: topAnchor),
            secondPhotoView.bottomAnchor.constraint(equalTo: bottomAnchor),
            secondPhotoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            secondPhotoView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func makeFollowingView(view: UIImageView) {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: frame.width * 0.66),
            view.centerYAnchor.constraint(equalTo: centerYAnchor),
            view.widthAnchor.constraint(equalToConstant: frame.width * 0.75),
            view.heightAnchor.constraint(equalToConstant: frame.height * 0.75)
        ])
    }
    
    private func makePreviousView(view: UIImageView) {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: -(frame.width * 0.66)),
            view.centerYAnchor.constraint(equalTo: centerYAnchor),
            view.widthAnchor.constraint(equalToConstant: frame.width * 0.75),
            view.heightAnchor.constraint(equalToConstant: frame.height * 0.75)
        ])
    }

    
    // MARK: - Helpers
    
    private func configureImageView() -> UIImageView {
        let photoView = UIImageView()
        photoView.clipsToBounds = true
        photoView.image = UIImage(named: "33")
        //photoView.backgroundColor = .clear
        photoView.contentMode = .scaleAspectFit
        return photoView
    }
}
