//
//  WebViewLoginViewController.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 24.11.2020.
//  Copyright © 2020 Dmitry Cherenkov. All rights reserved.
//

import UIKit
import WebKit

class WebViewLoginViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var dotsStack: UIStackView!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var firstDot: UIImageView!
    @IBOutlet weak var secondDot: UIImageView!
    @IBOutlet weak var thirdDot: UIImageView!
    @IBOutlet weak var webView: WKWebView! {
        didSet{
            webView.navigationDelegate = self
        }
    }
    
    // MARK: - Properties
    
    lazy var apiService = VkAuthorizationService()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blurView.isHidden = true
        dotsStack.isHidden = true
        webView.load(apiService.authorizeRequest)
    }

}

extension WebViewLoginViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        let token = params["access_token"]
        Session.shared.accessToken = token ?? ""
        performSegue(withIdentifier: "MainTabbarControllerSegue", sender: nil)
        
        decisionHandler(.cancel)
    }

    // MARK: - Functions
    
    func blur() {
        let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.dark))
        blurEffect.frame = view.bounds
        blurEffect.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.addSubview(blurEffect)
    }
    
    func animateLoading() {

        //hideKeyboard()
        blurView.frame.origin.y = -1000
        blurView.isHidden = false

        UIView.animate(withDuration: 0.5, animations: {
            self.blurView.frame.origin.y = 0
        }, completion: { _ in self.dotsStack.isHidden = false })

        UIView.animate(withDuration: 0.75, delay: 0.5, options: [.curveEaseInOut, .repeat, .autoreverse],
                       animations: {
                        UIView.setAnimationRepeatCount(3)
                        self.firstDot.alpha = 0
                       })

        UIView.animate(withDuration: 0.75, delay: 0.75, options: [.repeat, .autoreverse],
                       animations: {
                        UIView.setAnimationRepeatCount(3)
                        self.secondDot.alpha = 0
                       })

        UIView.animate(withDuration: 0.75, delay: 1, options: [.repeat, .autoreverse],
                       animations: {
                        UIView.setAnimationRepeatCount(3)
                        self.thirdDot.alpha = 0
                       }, completion: { _ in self.performSegue(withIdentifier: "MainTabbarControllerSegue", sender: nil) })
    }
    
}
