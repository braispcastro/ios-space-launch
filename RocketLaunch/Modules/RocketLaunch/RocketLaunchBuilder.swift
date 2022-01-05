//
//  RocketLaunchBuilder.swift
//  RocketLaunch
//
//  Created by Brais Castro on 24/12/21.
//

import Foundation
import UIKit.UIViewController

final class RocketLaunchBuilder: BaseBuilder {

    static func build() -> UIViewController {

        let viewController: RocketLaunchViewController = RocketLaunchViewController()
        let router: RocketLaunchRouter = RocketLaunchRouter(viewController: viewController)
        let interactor: RocketLaunchInteractor = RocketLaunchInteractor()
        let presenter: RocketLaunchPresenter = RocketLaunchPresenter(viewController: viewController,
                                                                     router: router,
                                                                     interactor: interactor)
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        
        return NavigationController(rootViewController: viewController)
    }

}
