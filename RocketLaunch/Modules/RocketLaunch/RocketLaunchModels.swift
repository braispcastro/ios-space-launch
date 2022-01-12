//
//  RocketLaunchModels.swift
//  RocketLaunch
//
//  Created by Brais Castro on 24/12/21.
//  Copyright © 2021 Brais Castro. All rights reserved.
//

import Foundation
import GoogleMobileAds

enum RocketLaunch {

    struct ViewModel: Equatable {
        let title: String
    }
    
    struct LaunchViewModel: Equatable {
        let imageUrl: String?
        let rocket: String
        let mission: String
        let provider: String
        let pad: String
        let windowStart: String
        let status: String
        let statusType: Space.Launch.Result.Status.StatusType
        let rawData: Space.Launch.Result
    }

}
