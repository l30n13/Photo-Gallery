//
//  GalleryViewModel.swift
//  Photo Gallery
//
//  Created by Mahbubur Rashid Leon on 6/6/22.
//

import Foundation
import IHProgressHUD
import NotificationBannerSwift

class GalleryViewModel {
    var photos: [PhotosViewModel] = []
    
    func fetchImages() {
        IHProgressHUD.show()
        RequestManager.request(using: .PHOTOS, params: nil, type: .get) { response in
            IHProgressHUD.dismiss()
            if let responseData = try? JSONDecoder().decode([PhotosModel].self, from: response) {
                self.photos = responseData.map(PhotosViewModel.init)
                print(self.photos)
            }
        } failure: { error in
            IHProgressHUD.dismiss()
            switch error {
            case .noInternet:
                let banner = FloatingNotificationBanner(title: "No Internet!", subtitle: "Please make sure you are connected to the internet. Thank you!", style: .danger)
                banner.show()
                break
            case .networkProblem:
                break
            case .errorDescription(let error):
                DLog(error.localizedDescription)
            }
        }

    }
}
