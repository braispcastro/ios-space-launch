//
//  SpaceModels.swift
//  RocketLaunch
//
//  Created by Brais Castro on 24/12/21.
//

import Foundation

struct Space {

    struct Launch: Decodable {
        
        let count: Int?
        let next: String?
        let previous: String?
        let results: [Result]?
        
        struct Result: Decodable {
            
            enum CodingKeys: String, CodingKey {
                case id, url, slug, name, status, net, probability, holdreason, failreason, rocket, mission, pad, image
                case lastUpdated = "lastUpdated"
                case windowEnd = "window_end"
                case windowStart = "window_start"
                case launchServiceProvider = "launch_service_provider"
                case webcastLive = "webcast_live"
            }
            
            let id: Int
            let url: String?
            let slug: String?
            let name: String?
            let status: Status?
            let lastUpdated: Date?
            let net: Date?
            let windowEnd: Date?
            let windowStart: Date?
            let probability: Int?
            let holdreason: String?
            let failreason: String?
            let launchServiceProvider: LaunchServiceProvider?
            let rocket: Rocket?
            let mission: Mission?
            let pad: Pad?
            let webcastLive: Bool?
            let image: String?
            
            
            struct Status: Decodable {
                
                let id: Int
                let name: String?
                let description: String?
                
            }
            
            struct LaunchServiceProvider: Decodable {
                
                let id: Int
                let url: String?
                let name: String?
                let type: String?
                
            }
            
            struct Rocket: Decodable {
                
                let id: Int
                let configuration: Configuration?
                
                struct Configuration: Decodable {
                    
                    enum CodingKeys: String, CodingKey {
                        case id, url, name, family, variant
                        case fullName = "full_name"
                    }
                    
                    let id: Int
                    let url: String?
                    let name: String?
                    let family: String?
                    let fullName: String?
                    let variant: String?
                    
                }
                
            }
            
            struct Mission: Decodable {
                
                let id: Int
                let name: String?
                let description: String?
                let type: String?
                let orbit: Orbit?
                
                struct Orbit: Decodable {
                    
                    let id: Int
                    let name: String?
                    let abbrev: String?
                    
                }
                
            }
            
            struct Pad: Decodable {
                
                enum CodingKeys: String, CodingKey {
                    case id, url, name, latitude, longitude, location
                    case agencyId = "agency_id"
                    case infoUrl = "info_url"
                    case wikiUrl = "wiki_url"
                    case mapUrl = "map_url"
                    case mapImage = "map_image"
                    case totalLaunchCount = "total_launch_count"
                }
                
                let id: Int
                let url: String?
                let agencyId: Int?
                let name: String?
                let infoUrl: String?
                let wikiUrl: String?
                let mapUrl: String?
                let latitude: String?
                let longitude: String?
                let location: Location?
                let mapImage: String?
                let totalLaunchCount: Int?
                
                struct Location: Decodable {
                    
                    enum CodingKeys: String, CodingKey {
                        case id, url, name
                        case countryCode = "country_code"
                        case mapImage = "map_image"
                        case totalLaunchCount = "total_launch_count"
                        case totalLandingCount = "total_landing_count"
                    }
                    
                    let id: Int
                    let url: String?
                    let name: String?
                    let countryCode: String?
                    let mapImage: String?
                    let totalLaunchCount: Int?
                    let totalLandingCount: Int?
                    
                }
                
            }
            
        }
        
    }
    
    struct Event: Decodable {
        
        let count: Int?
        let next: String?
        let previous: String?
        let results: [Result]?
        
        struct Result: Decodable {
            
            enum CodingKeys: String, CodingKey {
                case id, url, slug, name, type, description, location, date
                case webcastLive = "webcast_live"
                case newsUrl = "news_url"
                case videoUrl = "video_url"
                case featureImage = "feature_image"
            }
            
            let id: Int
            let url: String?
            let slug: String?
            let name: String?
            let type: EventType?
            let description: String?
            let webcastLive: Bool?
            let location: String?
            let newsUrl: String?
            let videoUrl: String?
            let featureImage: String?
            let date: Date?
            
            struct EventType: Decodable {
                
                let id: Int
                let name: String?
                
            }
            
        }
        
    }

}
