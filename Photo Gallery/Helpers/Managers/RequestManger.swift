//
//  RequestManger.swift
//  Photo Gallery
//
//  Created by Mahbubur Rashid Leon on 1/6/22.
//

import Foundation
import Alamofire

struct RequestManager {
    enum RequestType: String, CaseIterable {
        case get    = "GET"
        case post   = "POST"
    }
    enum ErrorType: Error {
        case noInternet
        case networkProblem
        case errorDescription(Error)
    }
    
    typealias successResponse = ((Data) -> Void)
    typealias errorResponse = ((ErrorType) -> Void)
    
    static func request(using url: HttpURL,
                 params: [String : AnyObject]?,
                 type: RequestType,
                 header: HTTPHeaders? = nil,
                 success: @escaping successResponse,
                 failure: @escaping errorResponse) {
        
        NetworkManager.isReachable { (reachable) in
            if reachable {
                AF.request(url.url, method: HTTPMethod(rawValue: type.rawValue), parameters: params, encoding: type == .post ? JSONEncoding.default : URLEncoding.queryString, headers: header).responseData { (responseData) -> Void in
                    DLog("API URL: \(responseData.response!.url!.absoluteURL)\nHeader data: \(String(describing: header))")
                    switch responseData.response?.statusCode {
                    case 200, 201:
                        switch responseData.result {
                        case .success(let responseData):
                            success(responseData)
                        case .failure(let error):
                            failure(.errorDescription(error))
                        }
                        break
                    case 400, 401, 404, 500:
                        failure(.networkProblem)
                    default:
                        failure(.networkProblem)
                    }
                }
            } else {
                DLog("No Internet.")
                failure(.noInternet)
            }
        }
    }
}

enum HttpURL: String {
    case PHOTOS           = "photos/random"
    
    var url: String {
        var configuration = Configuration()
        switch self {
        case .PHOTOS:
            return configuration.environment.baseURL + rawValue
        }
    }
}
