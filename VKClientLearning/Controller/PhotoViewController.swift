//
//  PhotoViewController.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 10.11.2020.
//  Copyright © 2020 Dmitry Cherenkov. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    // MARK: - Properties
    
    let apiService = VkApiService()
    var translationAnimator: UIViewPropertyAnimator!
    var photos: [UserPhotos] = []
    var photoIndex: Int = 0
    var currentPhotoCache: UIImage?
    
    private lazy var panRecognizer: UIPanGestureRecognizer = {
        let recognizer = UIPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(imagePanned(recognizer: )))
        return recognizer
    }()
    
    // MARK: - Subviews
    
    lazy var centerView: UIImageView = {
        return configureImageView()
    }()
    
    lazy var previousView: UIImageView = {
        return configureImageView()
    }()
    
    lazy var followingView: UIImageView = {
        return configureImageView()
    }()
    
    lazy var countLabel: UILabel = {
        let countLabel = UILabel()
        countLabel.backgroundColor = .clear
        countLabel.textColor = .white
        countLabel.textAlignment = .center
        countLabel.sizeToFit()
        return countLabel
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blur()
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        view.addSubview(centerView)
        view.addSubview(previousView)
        view.addSubview(followingView)
        view.addSubview(countLabel)
        
        centerView.translatesAutoresizingMaskIntoConstraints = false
        previousView.translatesAutoresizingMaskIntoConstraints = false
        followingView.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false

        setConstrainsts()
        
        view.addGestureRecognizer(panRecognizer)
        
        view.bringSubviewToFront(countLabel)
        
        getCountLabel()
        
        setupImages()
    }
    
    // MARK: - Helpers
    
    private func getCountLabel() {
        countLabel.text = "\(photoIndex + 1) from \(photos.count)"
    }
    
    private func setupImages() {
        apiService.loadImage(stringUrl: photos[photoIndex].fullSizePhoto) { image in
            self.centerView.image = image
            self.currentPhotoCache = image
            self.centerView.alpha = 1
            self.followingView.alpha = 0
            self.previousView.alpha = 0
            self.centerView.transform = .identity
            self.followingView.transform = .identity
            self.previousView.transform = .identity
            self.getCountLabel()
        }
        if photoIndex > 0 {
            apiService.loadImage(stringUrl: photos[photoIndex - 1].fullSizePhoto) { image in
                self.previousView.image = image
            }
        }
        if photoIndex < self.photos.count - 1 {
            apiService.loadImage(stringUrl: photos[photoIndex + 1].fullSizePhoto) { image in
                self.followingView.image = image
            }
        }
    }

    private func configureImageView() -> UIImageView {
        let photoView = UIImageView()
        photoView.clipsToBounds = true
        photoView.backgroundColor = .clear
        photoView.tag = 99
        return photoView
    }
    
    private func calculateWidth(index: Int) -> CGFloat {
        let scaleFactor = view.frame.width * 0.7
        var width: CGFloat
        
        if index < 0 || index >= photos.count - 1 {
            width = scaleFactor
        } else {
            if let imageWidth = currentPhotoCache?.size.width, let imageHeight = currentPhotoCache?.size.height {
                width = (scaleFactor / imageHeight) * imageWidth
            } else {
                width = scaleFactor
            }
        }
        
        return width
    }
    
    private func setConstrainsts() {
        
        centerView.contentMode = .scaleAspectFit
        followingView.contentMode = .scaleAspectFit
        previousView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            centerView.topAnchor.constraint(equalTo: view.topAnchor),
            centerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            centerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            centerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        followingView.alpha = 0
        NSLayoutConstraint.activate([
            followingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width),
            followingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            followingView.widthAnchor.constraint(equalToConstant: calculateWidth(index: photoIndex + 1)),
            followingView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.7)
        ])
        
        previousView.alpha = 0
        NSLayoutConstraint.activate([
            previousView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width),
            previousView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            previousView.widthAnchor.constraint(equalToConstant: calculateWidth(index: photoIndex - 1)),
            previousView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.7)
        ])
        
        NSLayoutConstraint.activate([
            countLabel.heightAnchor.constraint(equalToConstant: view.frame.height * 0.2),
            countLabel.topAnchor.constraint(equalTo: view.topAnchor),
            countLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func blur() {
        let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurEffect.frame = self.view.bounds
        blurEffect.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(blurEffect, at: 0)
    }
    
    private func isFirstOrLastImage(direction: PanState) -> Bool {
        if direction == .previous {
            return photoIndex > 0
        } else {
            return photoIndex < photos.count - 1
        }
    }
    
    // MARK: - Functions
    
    @objc private func imagePanned(recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: recognizer.view)
        let direction: PanState = translation.x > 0 ? .previous : .following
        let centerViewFrame = centerView.frame
        
        switch recognizer.state {
        
        case .began:
            
            translationAnimator = UIViewPropertyAnimator(duration: 0.6, curve: .easeInOut, animations: {
                self.centerView.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
                self.previousView.alpha = direction == .previous ? 1 : 0
                self.followingView.alpha = direction == .following ? 1 : 0
            })
            
            if isFirstOrLastImage(direction: direction) {
            
                translationAnimator.addAnimations({
                    let nextView = direction == .following ? self.followingView : self.previousView
                    nextView.center = self.centerView.center
                    nextView.frame = centerViewFrame
                    self.centerView.center = direction == .following ? self.previousView.center : self.followingView.center
                    self.centerView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                    self.centerView.alpha = 0
                }, delayFactor: 0.5)
            }
            
            translationAnimator.addCompletion({ (current) in
                guard current == .end else { return }
                if self.photoIndex >= 0 && self.photoIndex <= self.photos.count - 1 {
                    self.photoIndex = direction == .following ? self.photoIndex + 1 : self.photoIndex - 1
                    self.setupImages()
                }
            })
            
            translationAnimator.pauseAnimation()
            
        case .changed:
            let relativeTranslation = abs(translation.x) / (recognizer.view?.bounds.width ?? 1)
            let progress = max(0, min(1, relativeTranslation))
            translationAnimator.fractionComplete = progress
        case .ended:
            if isFirstOrLastImage(direction: direction), translationAnimator.fractionComplete > 0.3 {
                translationAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            } else {
                translationAnimator.stopAnimation(true)
                UIView.animate(withDuration: 0.3, animations: {
                    self.setupImages()
                })
            }
            
        default:
            break
        }
    }
}

// MARK: - Extensions

extension PhotoViewController {
    enum PanState {
        case following
        case previous
    }
}
