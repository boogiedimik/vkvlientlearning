//
//  TableViewSectionHeader.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 05.11.2020.
//  Copyright © 2020 Dmitry Cherenkov. All rights reserved.
//

import UIKit

class TableViewSectionHeader: UIView {
    
    //var labelLeadingConstraint: CGFloat = 10
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.textColor = .systemGray
        return label
    }()
    
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
        
        let gradient: CAGradientLayer = {
            let gradient = CAGradientLayer()
            gradient.colors = [UIColor.clear.cgColor, UIColor.init(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.55).cgColor]
            gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradient.endPoint = CGPoint(x: 2.0, y: 0.0)
            gradient.locations = [0, 1]
            return gradient
        }()
        
        
        //backgroundColor = .clear
        addSubview(label)

        label.text = "sda"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
        
        
    }
    
}
