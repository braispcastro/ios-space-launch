//
//  EventsBuilder.swift
//  Events
//
//  Created by Brais Castro on 24/12/21.
//

import Foundation
import UIKit.UIViewController

final class EventBuilder: BaseBuilder {

    static func build() -> UIViewController {

        let viewController: EventViewController = EventViewController()
        let router: EventRouter = EventRouter(viewController: viewController)
        let interactor: EventInteractor = EventInteractor()
        let presenter: EventPresenter = EventPresenter(viewController: viewController,
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
