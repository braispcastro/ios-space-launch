//
//  InformationRouter.swift
//  Information
//
//  Created by Brais Castro on 26/12/21.
//  Copyright © 2021 Brais Castro. All rights reserved.
//

import Foundation

protocol InformationRouterProtocol: BaseRouterProtocol {
    func navigateToLaunchPadLocator(name: String, lat: String, lon: String)
}

class InformationRouter: BaseRouter, InformationRouterProtocol {

    func navigateToLaunchPadLocator(name: String, lat: String, lon: String) {
        let vc = LaunchPadLocatorBuilder.build(name: name, latitude: lat, longitude: lon)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
}
