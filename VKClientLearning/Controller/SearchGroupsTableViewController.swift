//
//  SearchGroupsTableViewController.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 15.10.2020.
//  Copyright © 2020 Dmitry Cherenkov. All rights reserved.
//

import UIKit

class SearchGroupsTableViewController: UITableViewController, UISearchBarDelegate {

    // MARK: - Constants and Properties
    
    let apiService = VkApiService()
    var foundGroups = [Group]()
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Livecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        print(#function)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foundGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "SearchGroupsCell"
        let foundGroupsProfile = foundGroups[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SearchGroupsCell else { fatalError("The dequeued cell is not an instance of SearchGroupsCell") }
        
        apiService.loadImage(stringUrl: foundGroupsProfile.photo) { (image) in
            cell.groupAvatarImageView.image = image
        }
        cell.groupNameLabel.text = foundGroupsProfile.name
        
        if foundGroupsProfile.isMember == true {
            cell.addButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        } else {
            cell.addButton.setImage(UIImage(systemName: "plus.square.fill.on.square.fill"), for: .normal)
        }
        
//        cell.addButtonAction = {
//            [unowned self] in
//            if userGroupsProfile.userSubscribed == true {
//                for i in 0..<userGroups.count {
//                    if userGroups[i].name == userGroupsProfile.name {
//                        userGroups[i].userSubscribed = false
//                    }
//                }
//                tableView.reloadData()
//            } else {
//                for i in 0..<userGroups.count {
//                    if userGroups[i].name == userGroupsProfile.name {
//                        userGroups[i].userSubscribed = true
//                    }
//                }
//                tableView.reloadData()
//            }
//        }
        
        return cell
    }
    
    // MARK: - Functions
    
    func searchGroup(text: String?) {
        guard let text = text, !text.isEmpty else {
            foundGroups = []
            return
        }
        
        apiService.getData(method: .getSearchGroup, responseType: Group.self, groupSearchText: text) { [weak self] (foundGroups) in
            self?.foundGroups = foundGroups
            self?.tableView.reloadData()
        }
    }
    
    func reloadDataSource() {
        searchGroup(text: searchBar.text)
    }
    
    // MARK: - Delegates
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        reloadDataSource()
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
}
