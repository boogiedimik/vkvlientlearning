//
//  NavigationBarPopAnimator.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 16.11.2020.
//  Copyright © 2020 Dmitry Cherenkov. All rights reserved.
//

import UIKit




final class NavigationBarPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return  0.6
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }

        let originalFrame = source.view.frame
        let originalLayerPosition = source.view.layer.position
        let originalAnchorPoint = source.view.layer.anchorPoint
        let width = source.view.frame.width
        let height = source.view.frame.height

        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)

        destination.view.frame = originalFrame
        destination.view.layer.position.x -= width / 2
        destination.view.layer.position.y -= height / 2
        destination.view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        destination.view.transform = CGAffineTransform(rotationAngle: (90 * .pi) / 180)

        source.view.layer.position.x += width / 2
        source.view.layer.position.y -= height / 2
        source.view.layer.anchorPoint = CGPoint(x: 1, y: 0)



        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: .calculationModePaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.6, animations: {
                destination.view.transform = .identity
                source.view.transform = CGAffineTransform(rotationAngle: (-90 * .pi) / 180)
            })
        }) { finished in
            if finished && !transitionContext.transitionWasCancelled {
                source.removeFromParent()
                source.view.transform = .identity
                source.view.frame = originalFrame
                source.view.layer.position = originalLayerPosition
                source.view.layer.anchorPoint = originalAnchorPoint
                destination.view.frame = originalFrame
                destination.view.layer.anchorPoint = originalAnchorPoint
            } else if transitionContext.transitionWasCancelled {
                //destination.view.transform = .identity
                //source.view.transform = .identity
                source.view.frame = originalFrame
                source.view.layer.position = originalLayerPosition
                source.view.layer.anchorPoint = originalAnchorPoint
                destination.view.frame = originalFrame
                destination.view.layer.anchorPoint = originalAnchorPoint
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }

    }


}
