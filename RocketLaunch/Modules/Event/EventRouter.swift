//
//  EventsRouter.swift
//  Events
//
//  Created by Brais Castro on 24/12/21.
//  Copyright © 2021 Brais Castro. All rights reserved.
//

import Foundation

protocol EventRouterProtocol: BaseRouterProtocol {
    func navigateToEventInformation(event: Space.Event.Result)
}

class EventRouter: BaseRouter, EventRouterProtocol {
    
    func navigateToEventInformation(event: Space.Event.Result) {
        let vc = EventInformationBuilder.build(event: event)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

}
