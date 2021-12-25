//
//  EventsBuilder.swift
//  Events
//
//  Created by Brais Castro on 24/12/21.
//

import Foundation
import UIKit.UIViewController

final class EventsBuilder: BaseBuilder {

    static func build() -> UIViewController {

        let viewController: EventsViewController = EventsViewController()
        let router: EventsRouter = EventsRouter(viewController: viewController)
        let interactor: EventsInteractor = EventsInteractor()
        let presenter: EventsPresenter = EventsPresenter(viewController: viewController,
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
