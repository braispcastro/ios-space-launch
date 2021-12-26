//
//  EventInformationBuilder.swift
//  EventInformation
//
//  Created by Brais Castro on 26/12/21.
//

import Foundation
import UIKit.UIViewController

final class EventInformationBuilder: BaseBuilder {

    static func build(event: Space.Event.Result) -> UIViewController {

        let viewController: EventInformationViewController = EventInformationViewController()
        let router: EventInformationRouter = EventInformationRouter(viewController: viewController)
        let interactor: EventInformationInteractor = EventInformationInteractor()
        let presenter: EventInformationPresenter = EventInformationPresenter(viewController: viewController,
                                                                             router: router,
                                                                             interactor: interactor,
                                                                             event: event)
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        
        return viewController
    }

}
