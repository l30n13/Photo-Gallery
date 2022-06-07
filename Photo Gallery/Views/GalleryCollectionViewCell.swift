//
//  GalleryCollectionViewCell.swift
//  Photo Gallery
//
//  Created by Mahbubur Rashid Leon on 7/6/22.
//

import UIKit
import SDWebImage

class GalleryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        imageView.layer.cornerRadius = 10
        imageView.layer.shadowRadius = 3
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 1, height: 1)
        imageView.layer.shadowOpacity = 0.5
        imageView.clipsToBounds = true
        imageView.sd_imageTransition = .fade
    }
    
    func loadData(data: PhotosViewModel) {
        if let url = URL(string: data.thumbImage) {
            imageView.sd_setImage(with: url)
        }
    }
}
