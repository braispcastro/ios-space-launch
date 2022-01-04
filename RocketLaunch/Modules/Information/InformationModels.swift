//
//  InformationModels.swift
//  Information
//
//  Created by Brais Castro on 26/12/21.
//  Copyright © 2021 Brais Castro. All rights reserved.
//

import Foundation

enum Information {
    
    enum InformationType {
        case launch
        case provider
        case mission
        case pad
    }

    struct ViewModel: Equatable {
        let title: String
        let sections: [InformationType]
        let launch: Launch
        let provider: Provider?
        let mission: Mission?
        let pad: Pad?
    }
    
    struct Launch: Equatable {
        let imageUrl: String?
        let rocket: String
        let mission: String
        let provider: String
        let pad: String
        let windowStart: String
        let status: String
        let statusType: Space.Launch.Result.Status.StatusType
    }
    
    struct Provider: Equatable {
        let logoUrl: String?
        let name: String
        let description: String
        let countryCode: String
        let foundingYear: String
        let infoUrl: String?
        let wikiUrl: String?
    }
    
    struct Mission: Equatable {
        let logoUrl: String?
        let name: String
        let type: String
        let description: String
    }
    
    struct Pad: Equatable {
        let name: String
        let location: String
        let latitude: String?
        let longitude: String?
    }

}
