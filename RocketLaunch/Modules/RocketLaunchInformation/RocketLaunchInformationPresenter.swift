//
//  RocketLaunchInformationPresenter.swift
//  RocketLaunchInformation
//
//  Created by Brais Castro on 26/12/21.
//

import Foundation

protocol RocketLaunchInformationViewControllerProtocol: BaseViewControllerProtocol {
    func show(viewModel: RocketLaunchInformation.ViewModel)
}

protocol RocketLaunchInformationPresenterProtocol: BasePresenterProtocol {
    func prepareView()
}

final class RocketLaunchInformationPresenter<T: RocketLaunchInformationViewControllerProtocol, U: RocketLaunchInformationRouterProtocol>: BasePresenter<T, U> {
    
    let interactor: RocketLaunchInformationInteractorProtocol
    let launch: Space.Launch.Result
    
    init(viewController: T,
         router: U,
         interactor: RocketLaunchInformationInteractorProtocol,
         launch: Space.Launch.Result) {
        self.interactor = interactor
        self.launch = launch
        super.init(viewController: viewController, router: router)
    }
    
}

extension RocketLaunchInformationPresenter: RocketLaunchInformationPresenterProtocol {
    
    func prepareView() {
        let viewModel = RocketLaunchInformation.ViewModel(title: "Information")
        viewController.show(viewModel: viewModel)
    }
    
}

extension RocketLaunchInformationPresenter: RocketLaunchInformationInteractorCallbackProtocol {
    
}
