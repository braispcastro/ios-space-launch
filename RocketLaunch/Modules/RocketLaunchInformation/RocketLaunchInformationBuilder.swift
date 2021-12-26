//
//  RocketLaunchInformationBuilder.swift
//  RocketLaunchInformation
//
//  Created by Brais Castro on 26/12/21.
//

import Foundation
import UIKit.UIViewController

final class RocketLaunchInformationBuilder: BaseBuilder {

    static func build(launch: Space.Launch.Result) -> UIViewController {

        let viewController: RocketLaunchInformationViewController = RocketLaunchInformationViewController()
        let router: RocketLaunchInformationRouter = RocketLaunchInformationRouter(viewController: viewController)
        let interactor: RocketLaunchInformationInteractor = RocketLaunchInformationInteractor()
        let presenter: RocketLaunchInformationPresenter = RocketLaunchInformationPresenter(viewController: viewController,
                                                                                           router: router,
                                                                                           interactor: interactor,
                                                                                           launch: launch)
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        
        return viewController
    }

}
