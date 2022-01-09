//
//  RocketLaunchPresenter.swift
//  RocketLaunch
//
//  Created by Brais Castro on 24/12/21.
//

import Foundation
import GoogleMobileAds

protocol RocketLaunchViewControllerProtocol: BaseViewControllerProtocol {
    func show(viewModel: RocketLaunch.ViewModel)
    func showLaunches(launchList: [LaunchListProtocol])
}

protocol RocketLaunchPresenterProtocol: BasePresenterProtocol {
    func prepareView()
    func getLaunchesToShow()
    func launchTapped(launch: Space.Launch.Result)
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
    
    func getLaunchesToShow() {
        interactor.getLaunchList()
    }
    
    func launchTapped(launch: Space.Launch.Result) {
        router.navigateToInformation(launch: launch)
    }
    
}

extension RocketLaunchPresenter: RocketLaunchInteractorCallbackProtocol {
    
    func setLaunchList(launchList: [LaunchListProtocol]) {
        viewController.showLaunches(launchList: launchList)
    }
    
}
