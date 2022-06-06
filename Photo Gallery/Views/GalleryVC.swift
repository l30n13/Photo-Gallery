//
//  GalleryVC.swift
//  Photo Gallery
//
//  Created by Mahbubur Rashid Leon on 6/6/22.
//

import UIKit

class GalleryVC: UIViewController {

    let viewModel = GalleryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchImages()
    }


}

