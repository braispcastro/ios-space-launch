//
//  SpaceService.swift
//  RocketLaunch
//
//  Created by Brais Castro on 24/12/21.
//

import Foundation
import Alamofire

class SpaceService {
    
    /* TheSpaceDevs: https://ll.thespacedevs.com/2.2.0/swagger */
    
    static let shared = SpaceService()
    
    private enum SpaceServiceAPI {
        
        case launches
        case events
        
        func url() -> URL? {
            
            #if DEBUG
            let baseUrl = Constants.kLaunchBaseUrlDev
            #else
            let baseUrl = FirebaseRCService.shared.spaceBaseUrl!
            #endif
            
            let limit = FirebaseRCService.shared.spaceResultLimit!
            
            switch self {
            case .launches:
                return URL(string: "\(baseUrl)/launch/upcoming?mode=detailed&limit=\(limit)&format=json")
            case .events:
                return URL(string: "\(baseUrl)/event/upcoming?mode=detailed&limit=\(limit)&format=json")
            }
            
        }
        
    }
    
    func launches(success: @escaping (_ launch: Space.Launch) -> Void, failure: @escaping (_ error: Error?) -> Void) {
            
        guard let url = SpaceServiceAPI.launches.url() else {
            failure(nil)
            return
        }
            
        AF.request(url).responseDecodable(of: Space.Launch.self) { response in
            if let current = response.value {
                    success(current)
                    return
            }
            
            failure(response.error)
        }
            
    }
    
    func events(success: @escaping (_ launch: Space.Event) -> Void, failure: @escaping (_ error: Error?) -> Void) {
            
        guard let url = SpaceServiceAPI.events.url() else {
            failure(nil)
            return
        }
            
        AF.request(url).responseDecodable(of: Space.Event.self) { response in
            if let current = response.value {
                    success(current)
                    return
            }
            
            failure(response.error)
        }
            
    }
    
}
