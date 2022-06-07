//
//  Configuration.swift
//  Photo Gallery
//
//  Created by Mahbubur Rashid Leon on 6/6/22.
//

import Foundation

enum Environment: String {
    case STAGING = "staging"
    case PRODUCTION = "production"
    
    var baseURL: String {
        switch self {
        case .STAGING:
            return "https://api.unsplash.com/"
        case .PRODUCTION:
            return "https://api.unsplash.com/"
        }
    }
    
    var token: String {
        switch self {
        case .STAGING:
            return "A_0G-_qOq8HfL-FvxGVH3oEuhASqWvRPQx2bdANLo00"
        case .PRODUCTION:
            return "A_0G-_qOq8HfL-FvxGVH3oEuhASqWvRPQx2bdANLo00"
        }
    }
}

struct Configuration {
    lazy var environment: Environment = {
        if let configuration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String {
            if configuration.range(of: "Staging") != nil {
                return Environment.STAGING
            }
        }
        return Environment.PRODUCTION
    }()
}
