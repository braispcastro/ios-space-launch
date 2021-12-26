//
//  EventInformationPresenter.swift
//  EventInformation
//
//  Created by Brais Castro on 26/12/21.
//

import Foundation

protocol EventInformationViewControllerProtocol: BaseViewControllerProtocol {
    func show(viewModel: EventInformation.ViewModel)
}

protocol EventInformationPresenterProtocol: BasePresenterProtocol {
    func prepareView()
}

final class EventInformationPresenter<T: EventInformationViewControllerProtocol, U: EventInformationRouterProtocol>: BasePresenter<T, U> {
    
    let interactor: EventInformationInteractorProtocol
    let event: Space.Event.Result
    
    init(viewController: T,
         router: U,
         interactor: EventInformationInteractorProtocol,
         event: Space.Event.Result) {
        self.interactor = interactor
        self.event = event
        super.init(viewController: viewController, router: router)
    }
    
}

extension EventInformationPresenter: EventInformationPresenterProtocol {
    
    func prepareView() {
        let viewModel = EventInformation.ViewModel(title: "Information")
        viewController.show(viewModel: viewModel)
    }
    
}

extension EventInformationPresenter: EventInformationInteractorCallbackProtocol {
    
}
