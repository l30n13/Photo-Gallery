//
//  GalleryViewModel.swift
//  Photo Gallery
//
//  Created by Mahbubur Rashid Leon on 6/6/22.
//

import Foundation
import NotificationBannerSwift

class GalleryViewModel {
    var photos: [PhotosViewModel] = []
    
    var onCompleteLoading: (([PhotosViewModel]) -> Void)?
    func fetchImages(page: Int) {
        var configuration = Configuration()
        
        let params = [
            "page": page,
            "per_page": 20,
            "client_id": configuration.environment.token
        ] as [String : AnyObject]
        
        
        RequestManager.request(using: .PHOTOS, params: params, type: .get) { [weak self] response in
            guard let self = self else { return }
            
            if let responseData = try? JSONDecoder().decode([PhotosModel].self, from: response) {
                self.photos = responseData.map(PhotosViewModel.init)
                self.onCompleteLoading?(self.photos)
            }
        } failure: { error in
            switch error {
            case .noInternet:
                let banner = FloatingNotificationBanner(title: "No Internet!", subtitle: "Please make sure you are connected to the internet. Thank you!", style: .danger)
                banner.show()
                break
            case .networkProblem:
                let banner = FloatingNotificationBanner(title: "Network problem", subtitle: "There is a problem fetching image. Please try again later.", style: .danger)
                banner.show()
                DLog("Network problem")
                break
            case .errorDescription(let error):
                DLog(error.localizedDescription)
            }
        }
    }
}
