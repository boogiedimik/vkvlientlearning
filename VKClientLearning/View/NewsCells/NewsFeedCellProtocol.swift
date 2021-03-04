//
//  NewsFeedCellProtocol.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 01.03.2021.
//  Copyright © 2021 Dmitry Cherenkov. All rights reserved.
//

import Foundation
import UIKit

typealias NewsFeedCell = UITableViewCell & NewsFeedCellConfigurable

protocol NewsFeedCellConfigurable {
    func configureCell(item: NewsFeedSample)
}
