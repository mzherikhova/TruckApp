//
//  APIConnector.swift
//  TrucksApp
//
//  Created by Margarita Zherikhova on 28/05/2019.
//  Copyright © 2019 MacBook. All rights reserved.
//

import Alamofire
import Foundation
import CoreTelephony

class AlamofireSessionManager: SessionManager {
    convenience init() {
        
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "maps.googleapis.com": .disableEvaluation
        ]
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        let bundle = Bundle(for: APIConnector.self)
        let timeout: TimeInterval = (bundle.infoDictionary?["APIRequestTimeout"] as? Double) ?? 45.0
        configuration.timeoutIntervalForRequest = timeout
        self.init(configuration: configuration,
                  serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
    }
}

class APIConnector {
    
    let manager = AlamofireSessionManager()
}

extension APIConnector {
    static func isConnectionGood() -> Bool {
        
        let reachability = Reachability(hostname: "https://google.com")
        let status = reachability?.currentReachabilityStatus
        if status == .reachableViaWiFi {
            return true
        }
        
        let networkInfo = CTTelephonyNetworkInfo()
        if let networkString = networkInfo.currentRadioAccessTechnology {
            
            switch networkString {
            case CTRadioAccessTechnologyGPRS:
                return false
            case CTRadioAccessTechnologyEdge:
                return false
            case CTRadioAccessTechnologyCDMA1x:
                return false
            default:
                return true
            }
        }
        return true
    }
}


extension APIConnector {
    
    func apiResult<T>(from response: DataResponse<T>) -> APIResult<T, APIError> {
        switch response.result {
        case .success(let data):
            return APIResult.success(data)
        case .failure(let error):
            return APIResult.failure(error as! APIError)
        }
    }
}
