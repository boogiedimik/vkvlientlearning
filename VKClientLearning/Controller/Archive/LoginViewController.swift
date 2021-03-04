//
//  LoginViewController.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 10.10.2020.
//  Copyright © 2020 Dmitry Cherenkov. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Constants and properties
    
    var placeholder = "" //переменная для экстеншена

    // MARK: - Outlets
    
    @IBOutlet weak var loginViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var userIDTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var dotsStack: UIStackView!
    @IBOutlet weak var firstDot: UIImageView!
    @IBOutlet weak var secondDot: UIImageView!
    @IBOutlet weak var thirdDot: UIImageView!
    
    // MARK: - Livecycle
    
    override func viewDidAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        loginView?.addGestureRecognizer(hideKeyboardGesture)
        
        blurView.isHidden = true
        dotsStack.isHidden = true
        
        userIDTextField.delegate = self
        passwordTextField.delegate = self
        
        userIDTextField.tag = 0
        passwordTextField.tag = 1
        
        roundCorners(userIDTextField)
        roundCorners(passwordTextField)
        roundCorners(signInButton)
        
        userIDTextField.text = "putin"
        passwordTextField.text = "alina"
        
        blur()
    }
    

    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    // MARK: - Segue Perfoming and User ID Actions
    
    @IBAction func signIn(_ sender: UIButton) {
        let checkResult = checkUserID()
        if !checkResult {
            showLoginError()
        } else {
            animateLoading()
        }
    }
    
    func checkUserID() -> Bool {
        guard let userID = userIDTextField.text,
            let password = passwordTextField.text else { return false }
        
        if userID == "putin" && password == "alina" {
            return true
        } else {
            return false
        }
    }
    
    func showLoginError() {
        let alter = UIAlertController(title: "Error", message: "User ID or password is not valid. Please, try again.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alter.addAction(action)
        present(alter, animated: true, completion: nil)
    }
    
    // MARK: - Keyboard Actions
    
    // изменение констрейта при появлении клавиатуры + анимация
    @objc func keyboardWasShown(notification: Notification) {
        
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue
        guard loginViewBottomConstraint.constant == 0 else { return } //проверка, чтобы констрейнт не съезжал выше при повторном появлении клавиатуры
        loginViewBottomConstraint.constant -= kbSize.height
        
        UIView.animate(withDuration: 0.1) {
            self.loginView.layoutIfNeeded()
        }
        
    }
    
    // изменение констрейта при скрытии клавиатуры + анимация
    @objc func keyboardWillBeHidden(notification: Notification) {
        
        loginViewBottomConstraint.constant = 0
        
        UIView.animate(withDuration: 0.1) {
            self.loginView.layoutIfNeeded()
        }
        
    }

    // скрытие клавиатуры по тапу
    @objc func hideKeyboard() {
        self.loginView.endEditing(true)
    }
    
    func roundCorners(_ sender: UIView) {
        sender.layer.cornerRadius = view.layer.bounds.height / 45
        sender.clipsToBounds = true
    }
    
    // MARK: - Functions
    
    func blur() {
        let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.dark))
        blurEffect.frame = view.bounds
        blurEffect.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.addSubview(blurEffect)
    }
    
    func animateLoading() {
        
        hideKeyboard()
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

    // MARK: - TextField Extensions

// расширение для хайлайта рекдактируемого текстового поля + сброса плейсхолдера
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor(red: 117/255,
                                            green: 178/255,
                                            blue: 248/255,
                                            alpha: 1)
        placeholder = textField.placeholder ?? ""
        textField.placeholder = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor(red: 93/255,
                                            green: 153/255,
                                            blue: 221/255,
                                            alpha: 1)
        guard textField.placeholder == "" else { return }
        textField.placeholder = placeholder
    }
    
    // переключаемся между текстовыми полями при нажатии на "Ввод" или прячем клавиатуру, если вес заполнено + в будущем переход на следующее view
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         
        if textField === userIDTextField && passwordTextField.text == "" {
            passwordTextField.becomeFirstResponder()
        } else if textField === passwordTextField && userIDTextField.text == "" {
            userIDTextField.becomeFirstResponder()
        } else {
            hideKeyboard()
            //вызываем переход и проверку логина и пароля
            performSegue(withIdentifier: "MainTabbarControllerSegue", sender: nil)
        }
        return true
    }
    
}
