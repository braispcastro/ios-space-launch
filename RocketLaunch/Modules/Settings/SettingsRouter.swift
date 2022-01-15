//
//  SettingsRouter.swift
//  Settings
//
//  Created by Brais Castro on 24/12/21.
//  Copyright © 2021 Brais Castro. All rights reserved.
//

import Foundation

protocol SettingsRouterProtocol: BaseRouterProtocol {
    func showSettingsDialog(title: String, configType: Settings.ConfigType)
}

class SettingsRouter: BaseRouter, SettingsRouterProtocol {

    func showSettingsDialog(title: String, configType: Settings.ConfigType) {
        let vc = SettingsDialogBuilder.build(title: title, configType: configType)
        viewController.present(vc, animated: true)
    }
    
}
