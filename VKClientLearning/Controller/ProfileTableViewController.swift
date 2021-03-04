//
//  ProfileTableViewController.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 15.10.2020.
//  Copyright © 2020 Dmitry Cherenkov. All rights reserved.
//

import UIKit
import RealmSwift

class ProfileTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FriendsPickerDelegate {

    // MARK: - Constants and Properties
    
    lazy var apiService = VkApiService()
    lazy var realmService = RealmService()
    var userFriends = [User]()
    var filteredFriends = [User]()
    var sections: [String] = []
    var cashedSectionItems: [String: [User]] = [:]
    var refreshControl = UIRefreshControl()
    
    var token: NotificationToken?

    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var friendsPicker: FriendsPicker!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(reloadDataFromServer), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
        friendsPicker.delegate = self
        loadUsersFromRealm()
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let photosCollectionVC = segue.destination as? PhotosCollectionViewController
        else { fatalError("Unexpected destination: \(segue.destination)") }
        
        guard let selectedProfileCell = sender as? ProfileCell
        else { fatalError("Unexpected sender: \(String(describing: sender))") }
        
        guard let indexPath = tableView.indexPath(for: selectedProfileCell)
        else { fatalError("The selected cell is not being displayed by the table") }
        
        let selectedProfileId = getUserFriend(for: indexPath).id
        let profileName = getUserFriend(for: indexPath).fullName
        photosCollectionVC.selectedProfileId = selectedProfileId
        photosCollectionVC.profileName = profileName
    }
    
    @IBAction func unwindSeguePhotosVC(segue: UIStoryboardSegue) {
        //
        //        if segue.identifier == "backToPhotosVC" {
        //            guard let photosVC = segue.source as? PhotosCollectionViewController else { return }
        //            guard let selectedProfile = photosVC.selectedProfile else { return }
        //
        //            let userId = selectedProfile
        //            if let indexPath = userFriends.firstIndex(where: { (item) -> Bool in item.id == userId}) {
        //                userFriends[indexPath] = selectedProfile
        //            }
        //        }
        //        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getUsersFriendsForSection(for: section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ProfileCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ProfileCell else { fatalError("The dequeued cell is not an instance of ProfileCell") }
        let userFriendProfile = getUserFriend(for: indexPath)
        
        cell.friendNameLabel.text = userFriendProfile.fullName
        cell.friendCityLabel.text = userFriendProfile.city
        apiService.loadImage(stringUrl: userFriendProfile.photo ?? "") { (image) in
            cell.friendAvatarImageView.image = image
        }
        if userFriendProfile.isOnline {
            cell.friendAvatarImageView.onlineIndicator.isHidden = false
        }
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: {
                        cell.friendAvatarImageView.frame.origin.y -= 20
                        cell.friendNameLabel.frame.origin.y -= 20
                        cell.friendCityLabel.frame.origin.y -= 20
                       })
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerSectionView = TableViewSectionHeader(frame: CGRect(x: 0.0, y: 0.0, width: tableView.frame.width, height: tableView.sectionFooterHeight))
        headerSectionView.label.text = sections[section]
        return headerSectionView
        
    }
    
    // MARK: - Functions
    
    @objc func reloadDataFromServer() {
        loadUsersFromServer()
        refreshControl.endRefreshing()
    }
    
    private func loadUsersFromServer() {
        apiService.getData(method: .getFriends, responseType: User.self) { [weak self] (userFriends) in
            let userFriendsFromServer = userFriends.sorted { $0.lastName.lowercased() < $1.lastName.lowercased() }
            self?.userFriends = userFriendsFromServer
            self?.reloadDataSource()
            self?.friendsPicker.letters = self?.sections ?? []
            self?.realmService.saveToRealm(saveData: userFriendsFromServer)
            self?.tableView.reloadData()
        }
    }
    
    private func loadUsersFromRealm() {
        let userFriendsFromRealm = realmService.loadFromRealm(type: User.self).sorted { $0.lastName.lowercased() < $1.lastName.lowercased() }
        if !userFriendsFromRealm.isEmpty {
            userFriends = userFriendsFromRealm
            reloadDataSource()
            friendsPicker.letters = sections
            tableView.reloadData()
        } else {
            loadUsersFromServer()
        }
    }
    
    func reloadDataSource() {
        filterFriends(text: searchBar.text)
        let allLetters = filteredFriends.map { String($0.lastName.uppercased().prefix(1)) }
        sections = Array(Set(allLetters)).sorted()
        cashedSectionItems = [:]
    }
    
    func getUsersFriendsForSection(for section: Int) -> [User] {
        
        let sectionLetter = sections[section]
        
        if let sectionUserFriends = cashedSectionItems[sectionLetter] {
            return sectionUserFriends
        }
        
        let sectionUserFriends = filteredFriends.filter { $0.lastName.uppercased().prefix(1) == sectionLetter }
        cashedSectionItems[sectionLetter] = sectionUserFriends
        
        return sectionUserFriends
        
    }
    
    func getUserFriend(for indexPath: IndexPath) -> User {
        return getUsersFriendsForSection(for: indexPath.section)[indexPath.row]
    }
    
    func filterFriends(text: String?) {
        guard let text = text, !text.isEmpty else {
            filteredFriends = userFriends
            return
        }
        
        filteredFriends = userFriends.filter {
            $0.fullName.lowercased().contains(text.lowercased())
        }
    }
    
    // MARK: - Delegates
    
    func letterPicked(_ letter: String) {
        guard let index = sections.firstIndex(where: { $0 == letter }) else { return }
        let indexPath = IndexPath(row: 0, section: index)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        reloadDataSource()
        tableView.reloadData()
        friendsPicker.letters = sections
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
}

// MARK: - Extensions

extension ProfileTableViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        friendsPicker.unHighlightButton()
    }
}



