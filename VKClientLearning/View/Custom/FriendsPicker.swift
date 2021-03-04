//
//  FriendsPicker.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 03.11.2020.
//  Copyright © 2020 Dmitry Cherenkov. All rights reserved.
//

import UIKit

    // MARK: - Protocols

protocol FriendsPickerDelegate: class {
    func letterPicked(_ letter: String)
}

class FriendsPicker: UIView {

    // MARK: - Properties
    
    weak var delegate: FriendsPickerDelegate?
    
    var letters: [String] = [] {
        didSet {
            reload()
        }
    }
    
    // MARK: - Subviews
    
    private var buttons: [UIButton] = []
    private var lastPressedButton: UIButton?
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
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
        setupButtons()
        
        backgroundColor = .clear
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panAction))
        addGestureRecognizer(panGestureRecognizer)
         
    }
    
    private func setupButtons() {
        for letter in letters {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            button.setTitle(letter.uppercased(), for: .normal)
            button.addTarget(self,
                             action: #selector(buttonTapped),
                             for: .touchDown)
            buttons.append(button)
            stackView.addArrangedSubview(button)
            button.heightAnchor.constraint(equalToConstant: 13).isActive = true
            
        }
    }
    
    // MARK: - Actions
    
    @objc private func buttonTapped(_ sender: UIButton) {
        guard lastPressedButton != sender else { return }
        lastPressedButton = sender
        if let letter = sender.title(for: .normal) {
            delegate?.letterPicked(letter)
        }
    }
    
    @objc private func panAction(_ gesture: UIPanGestureRecognizer) {
        let anchorPoint = gesture.location(in: self)
        let buttonHeight = bounds.height / CGFloat(buttons.count)
        let buttonIndex = Int(anchorPoint.y / buttonHeight)
        if buttonIndex < buttons.count && buttonIndex >= 0 {
            let button = buttons[buttonIndex]
            unHighlightButton()
            button.isHighlighted = true
            buttonTapped(button)
        } else {
            unHighlightButton()
        }
    }
    
    func unHighlightButton() {
        buttons.forEach { $0.isHighlighted = false }
    }
    
    private func reload() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        buttons = []
        lastPressedButton = nil
        setupButtons()
    }
    
}
