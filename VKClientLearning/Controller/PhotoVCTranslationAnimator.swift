//
//  PhotoVCPopAnimator.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 19.11.2020.
//  Copyright © 2020 Dmitry Cherenkov. All rights reserved.
//

import UIKit

final class PhotoVCPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    public let CustomAnimatorTag = 99
    
    var duration: TimeInterval
    var isPresenting: Bool
    var originFrame: CGRect
    var photo: UIImage
    
    init(duration: TimeInterval, isPresenting: Bool, originFrame: CGRect, photo: UIImage) {
        self.duration = duration
        self.isPresenting = isPresenting
        self.originFrame = originFrame
        self.photo = photo
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return  duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        
        guard let source = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
        guard let destination = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        
        self.isPresenting ? container.addSubview(destination) : container.insertSubview(destination, belowSubview: source)
        
        let detailView = isPresenting ? destination : source
        
        guard let photoImageView = detailView.viewWithTag(CustomAnimatorTag) as? UIImageView else { return }
        photoImageView.image = photo
        photoImageView.alpha = 0
        
        let transitionImageView = UIImageView(frame: isPresenting ? originFrame : photoImageView.frame)
        transitionImageView.image = photo
        
        container.addSubview(transitionImageView)
        
        destination.frame = isPresenting ?  CGRect(x: source.frame.width, y: 0, width: destination.frame.width, height: destination.frame.height) : destination.frame
        destination.alpha = isPresenting ? 0 : 1
        destination.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, animations: {
            transitionImageView.frame = self.isPresenting ? photoImageView.frame : self.originFrame
            detailView.frame = self.isPresenting ? source.frame : CGRect(x: destination.frame.width, y: 0, width: destination.frame.width, height: destination.frame.height)
            detailView.alpha = self.isPresenting ? 1 : 0
        }, completion: { (finished) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            transitionImageView.removeFromSuperview()
            photoImageView.alpha = 1
        })
    }
    
    
}
