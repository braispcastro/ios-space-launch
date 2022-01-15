//
//  SettingsDialogModels.swift
//  RocketLaunch
//
//  Created by Brais Castro on 15/1/22.
//

import Foundation

enum SettingsDialog {

    struct ViewModel {
        let title: String
        let settingsType: Settings.ConfigType
        let rows: [Row]
    }
    
    struct Row {
        let title: String
        let selected: Bool
        let action: (() -> Void)
    }

}
