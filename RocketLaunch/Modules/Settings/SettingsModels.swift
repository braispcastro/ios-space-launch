//
//  SettingsModels.swift
//  Settings
//
//  Created by Brais Castro on 24/12/21.
//  Copyright © 2021 Brais Castro. All rights reserved.
//

import Foundation

enum Settings {

    struct ViewModel {
        let title: String
        let sections: [Section]
    }
    
    struct Section {
        let title: String
        let rows: [Row]
    }
    
    struct Row {
        let title: String
        let subtitle: String
        let enabled: Bool
        let uri: String?
        let configType: ConfigType?
    }
    
    enum ConfigType {
        case appearance
    }

}
