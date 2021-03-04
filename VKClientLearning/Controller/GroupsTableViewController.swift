//
//  GroupsTableViewController.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 15.10.2020.
//  Copyright © 2020 Dmitry Cherenkov. All rights reserved.
//

import UIKit

class GroupsTableViewController: UITableViewController {

    // MARK: - Constants and Properties
    
    lazy var apiService = VkApiService()
    lazy var realmService = RealmService()
    var userGroups = [Group]()

    // MARK: - Livecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGroupsFromRealm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Segues
    
//    @IBAction func unwindSegueFromSearchGroupVC(segue: UIStoryboardSegue) {
//
//        if segue.identifier == "backToGroupsVC" {
//            guard let searchGroupsVC = segue.source as? SearchGroupsTableViewController else { return }
//            //userGroups = searchGroupsVC.userGroups
//        }
//        tableView.reloadData()
//    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "UserGroupsCell"
        let userGroupsProfile = userGroups[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? UserGroupsCell else { fatalError("The dequeued cell is not an instance of ProfileCell") }
        
        apiService.loadImage(stringUrl: userGroupsProfile.photo) { (image) in
            cell.groupAvatarImageView.image = image
        }
        cell.groupNameLabel.text = userGroupsProfile.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            userGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?
    {
         return "Unsubscribe"
    }
    
    // MARK: - Actions
    
    @IBAction func reloadDataFromServer(_ sender: UIRefreshControl) {
        print("reloaddata")
        loadGroupsFromServer()
        sender.endRefreshing()
    }
    
    // MARK: - Functions
    
    private func loadGroupsFromServer() {
        apiService.getData(method: .getGroups, responseType: Group.self) { [weak self] (userGroups) in
            let userGroupsFromServer = userGroups.sorted { $0.id < $1.id }
            self?.userGroups = userGroupsFromServer
            self?.realmService.saveToRealm(saveData: userGroupsFromServer)
            self?.tableView.reloadData()
        }
    }
    
    private func loadGroupsFromRealm() {
        let userGroupsFromRealm = realmService.loadFromRealm(type: Group.self).sorted { $0.id < $1.id }
        if !userGroupsFromRealm.isEmpty {
            userGroups = userGroupsFromRealm
            tableView.reloadData()
        } else {
            loadGroupsFromServer()
        }
    }
    
}
