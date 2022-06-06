//
//  PhotosModel.swift
//  Photo Gallery
//
//  Created by Mahbubur Rashid Leon on 6/6/22.
//

import Foundation

struct PhotosModel: Codable {
    var id: String
    var urls: PhotoURL
    var links: PhotoLinks
}

struct PhotoURL: Codable {
    var raw: String
    var full: String
    var regular: String
    var small: String
    var thumb: String
    var small_s3: String
}

struct PhotoLinks: Codable {
    var html: String
    var download: String
    var download_location: String
}
