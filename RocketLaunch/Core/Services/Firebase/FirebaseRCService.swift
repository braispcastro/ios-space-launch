//
//  FirebaseRCService.swift
//  RocketLaunch
//
//  Created by Brais Castro on 6/1/22.
//

import Foundation
import FirebaseRemoteConfig

final class FirebaseRCService {
    
    static let shared = FirebaseRCService()
    
    // MARK: - Parameters
    
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    private(set) var spaceBaseUrl: String!
    private(set) var spaceResultLimit: String!
    private(set) var spaceAdsLimit: String!
    
    // MARK: - Initialization
    
    init() {
        let settings = RemoteConfigSettings()
        
        #if DEBUG
            settings.minimumFetchInterval = 0
        #else
            settings.minimumFetchInterval = 12
        #endif
        
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
        
        setupValues()
    }
    
    // MARK: - Private methods
    
    private func setupValues() {
        self.spaceBaseUrl = self.remoteConfig.configValue(forKey: Constants.kRemoteSpaceBaseUrl).stringValue!
        self.spaceResultLimit = self.remoteConfig.configValue(forKey: Constants.kRemoteSpaceResultLimit).stringValue!
        self.spaceAdsLimit = self.remoteConfig.configValue(forKey: Constants.kRemoteSpaceAdsLimit).stringValue!
    }
    
    // MARK: - Public methods
    
    func fetch() {
        remoteConfig.fetchAndActivate() { status, error in
            if status != .error {
                self.setupValues()
            }
        }
    }
}
