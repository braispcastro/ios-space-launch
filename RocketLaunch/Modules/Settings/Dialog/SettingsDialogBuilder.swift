//
//  SettingsDialogBuilder.swift
//  RocketLaunch
//
//  Created by Brais Castro on 15/1/22.
//

import Foundation
import UIKit.UIViewController

final class SettingsDialogBuilder: BaseBuilder {

    static func build(title: String, configType: Settings.ConfigType) -> UIViewController {

        let viewController: SettingsDialogViewController = SettingsDialogViewController()
        let router: SettingsDialogRouter = SettingsDialogRouter(viewController: viewController)
        let presenter: SettingsDialogPresenter = SettingsDialogPresenter(viewController: viewController,
                                                                         router: router,
                                                                         title: title,
                                                                         configType: configType)
        
        viewController.presenter = presenter

        return viewController
    }

}
