//
//  PreviewImageVC.swift
//  Photo Gallery
//
//  Created by Mahbubur Rashid Leon on 7/6/22.
//

import UIKit
import SDWebImage
import IHProgressHUD

class PreviewImageVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    lazy var barDownloadButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down.on.square"), style: .plain, target: self, action: #selector(downloadImage(_:)))
        button.tintColor = .red
        button.isEnabled = false
        return button
    }()
    
    var data: PhotosViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Gallery Image"
        navigationItem.rightBarButtonItem = barDownloadButton
        
        scrollView.delegate = self
        
        imageView.sd_imageTransition = .fade
        if let url = URL(string: data.fullImage) {
            IHProgressHUD.show()
            imageView.sd_setImage(with: url) { [weak self] (image, error, cacheType, url) in
                IHProgressHUD.dismiss()
                if error == nil {
                    self?.barDownloadButton.isEnabled  = true
                }
            }
        }
    }
}

extension PreviewImageVC {
    @objc private func downloadImage(_ sender: Any) {
        saveImage()
    }
    
    func saveImage() {
        guard let selectedImage = imageView.image else {
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            DLog(error.localizedDescription)
            IHProgressHUD.showError(withStatus: "Downloading image failed")
        } else {
            IHProgressHUD.showSuccesswithStatus("Image download successful")
            DLog("Success")
        }
    }
}

extension PreviewImageVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
