//
//  InformationBuilder.swift
//  Information
//
//  Created by Brais Castro on 26/12/21.
//

import Foundation
import UIKit.UIViewController

final class InformationBuilder: BaseBuilder {

    static func build(launch: Space.Launch.Result) -> UIViewController {

        let viewController: InformationViewController = InformationViewController()
        let router: InformationRouter = InformationRouter(viewController: viewController)
        let presenter: InformationPresenter = InformationPresenter(viewController: viewController,
                                                                   router: router,
                                                                   launch: launch)
        
        viewController.presenter = presenter
        
        return viewController
    }

}
