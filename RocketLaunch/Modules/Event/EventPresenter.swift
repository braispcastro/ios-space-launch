//
//  EventsPresenter.swift
//  Events
//
//  Created by Brais Castro on 24/12/21.
//

import Foundation

protocol EventViewControllerProtocol: BaseViewControllerProtocol {
    func show(viewModel: Event.ViewModel)
    func showEvents(eventList: [Event.EventViewModel])
    func listUpdateRejected()
}

protocol EventPresenterProtocol: BasePresenterProtocol {
    func prepareView()
    func getEventsToShow()
    func eventTapped(event: Space.Event.Result)
}

final class EventPresenter<T: EventViewControllerProtocol, U: EventRouterProtocol>: BasePresenter<T, U> {
    
    var lastEventsSync: Date?
    let interactor: EventInteractorProtocol
    
    init(viewController: T, router: U, interactor: EventInteractorProtocol) {
        self.interactor = interactor
        super.init(viewController: viewController, router: router)
    }
    
}

extension EventPresenter: EventPresenterProtocol {
    
    func prepareView() {
        let viewModel = Event.ViewModel(title: "Events")
        viewController.show(viewModel: viewModel)
    }
    
    func getEventsToShow() {
        guard let lastEventsSync = self.lastEventsSync else {
            interactor.getEventList()
            return
        }
        
        let interval = Date().timeIntervalSinceReferenceDate - lastEventsSync.timeIntervalSinceReferenceDate
        if interval > FirebaseRCService.shared.spaceSyncDelay {
            interactor.getEventList()
        } else {
            viewController.listUpdateRejected()
        }
    }
    
    func eventTapped(event: Space.Event.Result) {
        
    }
    
}

extension EventPresenter: EventInteractorCallbackProtocol {
    
    func setEventList(eventList: [Event.EventViewModel]) {
        if eventList.count > 0 {
            self.lastEventsSync = Date()
        }
        viewController.showEvents(eventList: eventList)
    }
    
}
