//
//  RocketLaunchRouter.swift
//  RocketLaunch
//
//  Created by Brais Castro on 24/12/21.
//  Copyright © 2021 Brais Castro. All rights reserved.
//

import Foundation

protocol RocketLaunchRouterProtocol: BaseRouterProtocol {
    func navigateToInformation(launch: Space.Launch.Result)
}

class RocketLaunchRouter: BaseRouter, RocketLaunchRouterProtocol {

    func navigateToInformation(launch: Space.Launch.Result) {
        let vc = InformationBuilder.build(launch: launch)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
}
