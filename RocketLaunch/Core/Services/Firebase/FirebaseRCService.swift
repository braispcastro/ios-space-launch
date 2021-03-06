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
    private(set) var privacyPolicyURI: String!
    private(set) var termsOfUseURI: String!
    private(set) var supportFormURI: String!
    private(set) var spaceSyncDelay: Double!
    private(set) var googleAdBannerUnitId: String!
    
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
        self.privacyPolicyURI = self.remoteConfig.configValue(forKey: Constants.kRemotePrivacyPolicyURI).stringValue!
        self.termsOfUseURI = self.remoteConfig.configValue(forKey: Constants.kRemoteTermsOfUseURI).stringValue!
        self.supportFormURI = self.remoteConfig.configValue(forKey: Constants.kRemoteSuportFormURI).stringValue!
        self.spaceSyncDelay = Double(self.remoteConfig.configValue(forKey: Constants.kRemoteSpaceSyncDelay).stringValue!)!
        
        
        #if DEBUG
        self.googleAdBannerUnitId = Constants.kTestingGoogleAdBannerId
        #else
        self.googleAdBannerUnitId = self.remoteConfig.configValue(forKey: Constants.kRemoteGoogleAdBannerUnitId).stringValue!
        #endif
    }
    
    // MARK: - Public methods
    
    func fetch(completion: @escaping () -> Void) {
        remoteConfig.fetchAndActivate() { status, error in
            if status != .error {
                self.setupValues()
            }
            completion()
        }
    }
}
