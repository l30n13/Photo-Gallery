//
//  PhotosViewModel.swift
//  Photo Gallery
//
//  Created by Mahbubur Rashid Leon on 6/6/22.
//

import Foundation

struct PhotosViewModel {
    var photoData: PhotosModel
    
    var id: String {
        photoData.id
    }
    
    var thumbImage: String {
        photoData.urls.thumb
    }
    
    var fullImage: String {
        photoData.urls.full
    }
    
    var downloadImage: String {
        photoData.links.download
    }
}
