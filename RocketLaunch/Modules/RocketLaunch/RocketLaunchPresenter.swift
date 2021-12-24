//
//  RocketLaunchPresenter.swift
//  RocketLaunch
//
//  Created by Brais Castro on 24/12/21.
//

import Foundation

protocol RocketLaunchViewControllerProtocol: BaseViewControllerProtocol {
    func show(viewModel: RocketLaunch.ViewModel)
}

protocol RocketLaunchPresenterProtocol: BasePresenterProtocol {
    func prepareView()
}

final class RocketLaunchPresenter<T: RocketLaunchViewControllerProtocol, U: RocketLaunchRouterProtocol>: BasePresenter<T, U> {
    
    let interactor: RocketLaunchInteractorProtocol
    
    init(viewController: T, router: U, interactor: RocketLaunchInteractorProtocol) {
        self.interactor = interactor
        super.init(viewController: viewController, router: router)
    }
    
}

extension RocketLaunchPresenter: RocketLaunchPresenterProtocol {
    
    func prepareView() {
        let viewModel = RocketLaunch.ViewModel(title: "Launches")
        viewController.show(viewModel: viewModel)
    }
    
}

extension RocketLaunchPresenter: RocketLaunchInteractorCallbackProtocol {
    
}
