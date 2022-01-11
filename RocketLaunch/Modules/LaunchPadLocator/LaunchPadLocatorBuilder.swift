//
//  LaunchPadLocatorBuilder.swift
//  RocketLaunch
//
//  Created by Brais Castro on 4/1/22.
//

import Foundation
import UIKit.UIViewController

final class LaunchPadLocatorBuilder: BaseBuilder {

    static func build(name: String, latitude: String, longitude: String) -> UIViewController {

        let viewController: LaunchPadLocatorViewController = LaunchPadLocatorViewController()
        let router: LaunchPadLocatorRouter = LaunchPadLocatorRouter(viewController: viewController)
        let presenter: LaunchPadLocatorPresenter = LaunchPadLocatorPresenter(viewController: viewController,
                                                                             router: router,
                                                                             name: name,
                                                                             latitude: latitude,
                                                                             longitude: longitude)
        
        viewController.presenter = presenter

        return viewController
    }

}
