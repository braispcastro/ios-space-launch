//
//  EventsPresenter.swift
//  Events
//
//  Created by Brais Castro on 24/12/21.
//

import Foundation

protocol EventsViewControllerProtocol: BaseViewControllerProtocol {
    func show(viewModel: Events.ViewModel)
    func showEvents(eventList: [Events.Event])
}

protocol EventsPresenterProtocol: BasePresenterProtocol {
    func prepareView()
    func getEventsToShow()
}

final class EventsPresenter<T: EventsViewControllerProtocol, U: EventsRouterProtocol>: BasePresenter<T, U> {
    
    let interactor: EventsInteractorProtocol
    
    init(viewController: T, router: U, interactor: EventsInteractorProtocol) {
        self.interactor = interactor
        super.init(viewController: viewController, router: router)
    }
    
}

extension EventsPresenter: EventsPresenterProtocol {
    
    func prepareView() {
        let viewModel = Events.ViewModel(title: "Events")
        viewController.show(viewModel: viewModel)
    }
    
    func getEventsToShow() {
        interactor.getEventList()
    }
    
}

extension EventsPresenter: EventsInteractorCallbackProtocol {
    
    func setEventList(eventList: [Events.Event]) {
        viewController.showEvents(eventList: eventList)
    }
    
}
