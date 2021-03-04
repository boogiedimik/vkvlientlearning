//
//  NewsFeedTableViewController.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 05.11.2020.
//  Copyright © 2020 Dmitry Cherenkov. All rights reserved.
//

import UIKit

class NewsFeedTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    lazy var apiService = VkApiService()
    var newsFeed: [NewsFeedSample] = []
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        newsFeed = apiService.generateNewsFeed(numberOfNews: 25)
    }
    
    // MARK: - TableView Data Source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let newsFeedItem = newsFeed[indexPath.section]
        let hasImages = newsFeedItem.photos.count <= 0 ? false : true
        let postType = newsFeedItem.type
        
        var identifier = ""
        
        switch indexPath.row {
        
        case 0:
            identifier = "NewsFeedHeaderCell"
        case 1 where postType == .post:
            identifier = "NewsFeedPostCell"
        case 1 where postType == .photo:
            identifier = "NewsFeedPhotoCell"
        case 2 where (postType == .post && hasImages):
            identifier = "NewsFeedPhotoCell"
        case 2 where postType == .post && !hasImages || postType == .photo:
            identifier = "NewsFeedFooterCell"
        case 3:
            identifier = "NewsFeedFooterCell"
        default:
            break
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! NewsFeedCell
        cell.configureCell(item: newsFeedItem)
        
        if identifier == "NewsFeedHeaderCell" || identifier == "NewsFeedPostCell" {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        }
        
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return newsFeed.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let newsFeedItem = newsFeed[section]
        return ((newsFeedItem.photos.count <= 0 && newsFeedItem.type == .post) || newsFeedItem.type == .photo) ? 3 : 4
    }
    
}
