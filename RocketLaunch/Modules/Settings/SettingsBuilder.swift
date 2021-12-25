//
//  SettingsBuilder.swift
//  Settings
//
//  Created by Brais Castro on 24/12/21.
//

import Foundation
import UIKit.UIViewController

final class SettingsBuilder: BaseBuilder {

    static func build() -> UIViewController {

        let viewController: SettingsViewController = SettingsViewController()
        let router: SettingsRouter = SettingsRouter(viewController: viewController)
        let interactor: SettingsInteractor = SettingsInteractor()
        let presenter: SettingsPresenter = SettingsPresenter(viewController: viewController,
                                                                     router: router,
                                                                     interactor: interactor)
        
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        
        let navController: UINavigationController = UINavigationController(rootViewController: viewController)
        let backButtonImage = UIImage(systemName: "arrow.backward")
        navController.navigationBar.backIndicatorImage = backButtonImage
        navController.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }

}
