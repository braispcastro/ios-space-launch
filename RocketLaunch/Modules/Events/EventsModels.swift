//
//  EventsModels.swift
//  Events
//
//  Created by Brais Castro on 24/12/21.
//  Copyright © 2021 Brais Castro. All rights reserved.
//

import Foundation

enum Events {

    struct ViewModel: Equatable {
        let title: String
    }
    
    struct Event: Equatable {
        let imageUrl: String
        let name: String
        let location: String
        let type: String
        let description: String
        let date: String
    }

}
