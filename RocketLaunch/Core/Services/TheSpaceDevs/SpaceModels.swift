//
//  SpaceModels.swift
//  RocketLaunch
//
//  Created by Brais Castro on 24/12/21.
//

import Foundation

struct Space {

    // MARK: - Launch
    
    struct Launch: Decodable, Equatable {
        
        let count: Int?
        let next: String?
        let previous: String?
        let results: [Result]?
        
        struct Result: Decodable, Equatable {
            
            enum CodingKeys: String, CodingKey {
                case id, url, name, status, net, probability, holdreason, failreason, rocket, mission, pad, image
                case lastUpdated = "last_updated"
                case windowEnd = "window_end"
                case windowStart = "window_start"
                case launchServiceProvider = "launch_service_provider"
                case webcastLive = "webcast_live"
                case missionPatches = "mission_patches"
            }
            
            let id: String
            let url: String?
            let name: String?
            let status: Status?
            let lastUpdated: String?
            let net: String?
            let windowEnd: String?
            let windowStart: String?
            let probability: Int?
            let holdreason: String?
            let failreason: String?
            let launchServiceProvider: LaunchServiceProvider?
            let rocket: Rocket?
            let mission: Mission?
            let pad: Pad?
            let webcastLive: Bool?
            let image: String?
            let missionPatches: [MissionPatch]?
            
            
            struct Status: Decodable, Equatable {
                
                enum CodingKeys: String, CodingKey {
                    case name, abbrev, description
                    case type = "id"
                }
                
                //let id: Int
                let name: String?
                let abbrev: String?
                let description: String?
                let type: StatusType?
                
                enum StatusType: Int, Codable {
                    case go = 1
                    case toBeDetermined = 2
                    case success = 3
                    case failure = 4
                    case hold = 5
                    case inFlight = 6
                    case partialFailure = 7
                    case toBeConfirmed = 8
                    case unknown
                }
                
            }
            
            struct LaunchServiceProvider: Decodable, Equatable {
                
                enum CodingKeys: String, CodingKey {
                    case id, url, name, abbrev, type, description
                    case countryCode = "country_code"
                    case foundingYear = "founding_year"
                    case logoUrl = "logo_url"
                    case infoUrl = "info_url"
                    case wikiUrl = "wiki_url"
                }
                
                let id: Int
                let url: String?
                let name: String?
                let abbrev: String?
                let type: String?
                let countryCode: String?
                let description: String?
                let foundingYear: String?
                let logoUrl: String?
                let infoUrl: String?
                let wikiUrl: String?
                
            }
            
            struct Rocket: Decodable, Equatable {
                
                let id: Int
                let configuration: Configuration?
                
                struct Configuration: Decodable, Equatable {
                    
                    enum CodingKeys: String, CodingKey {
                        case id, url, name, description, family, variant, manufacturer
                        case fullName = "full_name"
                    }
                    
                    let id: Int
                    let url: String?
                    let name: String?
                    let description: String?
                    let family: String?
                    let fullName: String?
                    let variant: String?
                    let manufacturer: Manufacturer?
                    
                }
                
                struct Manufacturer: Decodable, Equatable {
                    
                    enum CodingKeys: String, CodingKey {
                        case id, url, name, abbrev, type, description
                        case countryCode = "country_code"
                        case foundingYear = "founding_year"
                        case logoUrl = "logo_url"
                        case infoUrl = "info_url"
                        case wikiUrl = "wiki_url"
                    }
                    
                    let id: Int
                    let url: String?
                    let name: String?
                    let abbrev: String?
                    let type: String?
                    let countryCode: String?
                    let description: String?
                    let foundingYear: String?
                    let logoUrl: String?
                    let infoUrl: String?
                    let wikiUrl: String?
                    
                }
                
            }
            
            struct Mission: Decodable, Equatable {
                
                let id: Int
                let name: String?
                let description: String?
                let type: String?
                let orbit: Orbit?
                
                struct Orbit: Decodable, Equatable {
                    
                    let id: Int
                    let name: String?
                    let abbrev: String?
                    
                }
                
            }
            
            struct Pad: Decodable, Equatable {
                
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
                
                struct Location: Decodable, Equatable {
                    
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
            
            struct MissionPatch: Decodable, Equatable {
                
                enum CodingKeys: String, CodingKey {
                    case id, name
                    case imageUrl = "image_url"
                }
                
                let id: Int
                let name: String?
                let imageUrl: String?
                
            }
            
        }
        
    }
    
    // MARK: - Event
    
    struct Event: Decodable, Equatable {
        
        let count: Int?
        let next: String?
        let previous: String?
        let results: [Result]?
        
        struct Result: Decodable, Equatable {
            
            enum CodingKeys: String, CodingKey {
                case id, url, name, type, description, location, date
                case webcastLive = "webcast_live"
                case newsUrl = "news_url"
                case videoUrl = "video_url"
                case featureImage = "feature_image"
            }
            
            let id: Int
            let url: String?
            let name: String?
            let type: EventType?
            let description: String?
            let webcastLive: Bool?
            let location: String?
            let newsUrl: String?
            let videoUrl: String?
            let featureImage: String?
            let date: String?
            
            struct EventType: Decodable, Equatable {
                
                let id: Int
                let name: String?
                
            }
            
        }
        
    }

}
