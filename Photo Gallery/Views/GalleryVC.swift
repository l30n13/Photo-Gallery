//
//  GalleryVC.swift
//  Photo Gallery
//
//  Created by Mahbubur Rashid Leon on 6/6/22.
//

import UIKit
import IHProgressHUD

class GalleryVC: UIViewController {
    lazy var refreshControl = UIRefreshControl()
    @IBOutlet weak var collectionView: UICollectionView!
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
        label.textColor = UIColor.black
        label.font = UIFont(name: "Avenir Next Medium", size: 20)
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "No Data Found"
        return label
    }()
    
    private let viewModel = GalleryViewModel()
    private var galleryImageList: [PhotosViewModel] = []
    private var page: Int = 1
    private var isReloaded = false, isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadImages()
    }
}

extension GalleryVC {
    private func setupUI() {
        navigationItem.title = "Photo Gallery"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        refreshControl.addTarget(self, action: #selector(refreshCollectionView(_:)), for: .valueChanged)
        
        collectionView.refreshControl = refreshControl
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension GalleryVC {
    func loadImages() {
        IHProgressHUD.show()
        viewModel.fetchImages(page: page)
        viewModel.onCompleteLoading = { [weak self] (data) in
            IHProgressHUD.dismiss()
            guard let self = self else { return }
            self.galleryImageList = data
            self.collectionView.reloadData()
            
            self.refreshControl.endRefreshing()
        }
    }
    
    func loadMoreImage() {
        isLoading = true
        page += 1
        viewModel.fetchImages(page: page)
        viewModel.onCompleteLoading = { [weak self] (data) in
            guard let self = self else { return }
            
            self.isLoading = false
            data.forEach { self.galleryImageList.append($0) }
            self.collectionView.reloadData()
            
            self.refreshControl.endRefreshing()
        }
    }
}

extension GalleryVC {
    @objc private func refreshCollectionView(_ sender: Any) {
        isReloaded = false
        page = 1
        loadImages()
    }
}

extension GalleryVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
        cell.loadData(data: galleryImageList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Gallery", bundle: nil).instantiateViewController(withIdentifier: "PreviewImageVC") as? PreviewImageVC {
            vc.data = galleryImageList[indexPath.row]
            let navController = UINavigationController(rootViewController: vc)
            self.navigationController?.present(navController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == galleryImageList.count - 4 && !self.isLoading {
            loadMoreImage()
        }
    }
}

extension GalleryVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
