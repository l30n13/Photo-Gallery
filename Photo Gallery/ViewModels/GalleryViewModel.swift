//
//  GalleryViewModel.swift
//  Photo Gallery
//
//  Created by Mahbubur Rashid Leon on 6/6/22.
//

import Foundation
import IHProgressHUD
import NotificationBannerSwift
import RxSwift
import RxCocoa

class GalleryViewModel {
    var photos = PublishSubject<[PhotosViewModel]>()
    
    func fetchImages() {
        IHProgressHUD.show()
        var configuration = Configuration()
        
        let params = [
            "count": 30,
            "client_id": configuration.environment.token
        ] as [String : AnyObject]
        
        RequestManager.request(using: .PHOTOS, params: params, type: .get) { response in
            IHProgressHUD.dismiss()
            if let responseData = try? JSONDecoder().decode([PhotosModel].self, from: response) {
                self.photos.onNext(responseData.map(PhotosViewModel.init))
            }
        } failure: { error in
            IHProgressHUD.dismiss()
            switch error {
            case .noInternet:
                let banner = FloatingNotificationBanner(title: "No Internet!", subtitle: "Please make sure you are connected to the internet. Thank you!", style: .danger)
                banner.show()
                break
            case .networkProblem:
                DLog("Network problem")
                break
            case .errorDescription(let error):
                DLog(error.localizedDescription)
            }
        }

    }
}
