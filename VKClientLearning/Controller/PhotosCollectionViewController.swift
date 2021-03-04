//
//  PhotosCollectionViewController.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 15.10.2020.
//  Copyright © 2020 Dmitry Cherenkov. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    
    // MARK: - Constants and Properties
    
    lazy var apiService = VkApiService()
    lazy var realmService = RealmService()
    var selectedProfileId: Int?
    var photos: [UserPhotos]?
    var profileName: String?
    var selectedFrame: CGRect?
    var selectedPhoto: UIImage?
    var customInteractor: PhotosControllerInteractor?
    var refreshControl = UIRefreshControl()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(profileName ?? "User")'s Photos"
        
        let doubleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cellDoubleTaped(gesture: )))
        doubleTapGesture.numberOfTapsRequired = 2
        self.collectionView.addGestureRecognizer(doubleTapGesture)
        
        refreshControl.addTarget(self, action: #selector(reloadDataFromServer), for: UIControl.Event.valueChanged)
        collectionView.refreshControl = refreshControl
        
        loadPhotosFromRealm()
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let photoVC = segue.destination as? PhotoViewController {
            
            guard let selectedPhotoCell = sender as? PhotoCell
            else { fatalError("Unexpected sender: \(String(describing: sender))") }
            
            guard let indexPath = collectionView.indexPath(for: selectedPhotoCell)
            else { fatalError("The selected cell is not being displayed by the table") }
            
            if let photos = photos {
                photoVC.photos = photos
                photoVC.photoIndex = indexPath.row
            }
        }
    }
   
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let photo = selectedProfile?.photos?[indexPath.row].photo {
//            selectedPhoto = photo
//        }
//        let theAttributes:UICollectionViewLayoutAttributes! = collectionView.layoutAttributesForItem(at: indexPath)
//        selectedFrame = collectionView.convert(theAttributes.frame, to: collectionView.superview)
//    }
    
    // MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifier = "PhotoCell"
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? PhotoCell
        else { fatalError("The dequeued cell is not an instance of PhotoCell") }
        
        if let userPhotos = photos?[indexPath.row] {
            
            apiService.loadImage(stringUrl: userPhotos.previewPhoto) { image in
                cell.photoImageView.image = image
            }
            cell.likeControl.likesCount = userPhotos.likesCount
            cell.likeControl.isLiked = userPhotos.likedByUser == 0 ? false : true
            
            cell.likeButtonAction = {
                [unowned self] in
                didLike(indexPath)
            }
        }
        return cell
    }
    
    // MARK: - Functions
    
    @objc func reloadDataFromServer() {
        print("reloaddata")
        loadPhotosFromServer()
        refreshControl.endRefreshing()
    }
    
    private func loadPhotosFromServer() {
        apiService.getData(method: .getPhotos, responseType: UserPhotos.self, userOrGroupId: selectedProfileId) { [weak self] (photos) in
            let userPhotosFromServer = photos
            self?.photos = userPhotosFromServer
            self?.realmService.saveToRealm(saveData: userPhotosFromServer)
            self?.collectionView.reloadData()
        }
    }
    
    private func loadPhotosFromRealm() {
        let userPhotosFromRealm = realmService.loadFromRealm(type: UserPhotos.self).filter { $0.ownerId == selectedProfileId }.sorted { $0.date > $1.date }
        if !userPhotosFromRealm.isEmpty {
            photos = userPhotosFromRealm
            collectionView.reloadData()
        } else {
            loadPhotosFromServer()
        }
    }
    
    @objc private func cellDoubleTaped(gesture: UITapGestureRecognizer) {
        let pointInCollectionView: CGPoint = gesture.location(in: self.collectionView)
        guard let indexPath: IndexPath = self.collectionView.indexPathForItem(at: pointInCollectionView) else { return }
        didLike(indexPath)
        collectionView.reloadData()
    }
    
    private func didLike(_ indexPath: IndexPath) {
        if let userPhoto = photos?[indexPath.row] {
            userPhoto.likedByUser = userPhoto.likedByUser == 0 ? 1 : 0
            if userPhoto.likedByUser == 0 {
                userPhoto.likesCount -= 1
            } else {
                userPhoto.likesCount += 1
            }
            photos?[indexPath.row] = userPhoto
        }
    }
}

// MARK: - Delegates

extension PhotosCollectionViewController: UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout {
    
    func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let ci = customInteractor else { return nil }
        return ci.transitionInProgress ? customInteractor : nil
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let frame = self.selectedFrame else { return nil }
        
        switch operation {
        case .push:
            self.customInteractor = PhotosControllerInteractor(attachTo: toVC)
            return PhotoVCPopAnimator(duration: TimeInterval(UINavigationController.hideShowBarDuration), isPresenting: true, originFrame: frame, photo: selectedPhoto!)
        default:
            return PhotoVCPopAnimator(duration: TimeInterval(UINavigationController.hideShowBarDuration), isPresenting: false, originFrame: frame, photo: selectedPhoto!)
        }
    }
}

extension PhotosCollectionViewController {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width / 3)
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
