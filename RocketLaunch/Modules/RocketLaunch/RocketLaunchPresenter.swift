//
//  RocketLaunchPresenter.swift
//  RocketLaunch
//
//  Created by Brais Castro on 24/12/21.
//

import Foundation

protocol RocketLaunchViewControllerProtocol: BaseViewControllerProtocol {
    func show(viewModel: RocketLaunch.ViewModel)
    func showLaunches(launchList: [RocketLaunch.LaunchViewModel])
    func listUpdateRejected()
}

protocol RocketLaunchPresenterProtocol: BasePresenterProtocol {
    func prepareView()
    func getLaunchesToShow()
    func launchTapped(launch: Space.Launch.Result)
}

final class RocketLaunchPresenter<T: RocketLaunchViewControllerProtocol, U: RocketLaunchRouterProtocol>: BasePresenter<T, U> {
    
    var lastLaunchesSync: Date?
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
        guard let lastLaunchesSync = self.lastLaunchesSync else {
            interactor.getLaunchList()
            return
        }
        
        let interval = Date().timeIntervalSinceReferenceDate - lastLaunchesSync.timeIntervalSinceReferenceDate
        if interval > FirebaseRCService.shared.spaceSyncDelay {
            interactor.getLaunchList()
        } else {
            viewController.listUpdateRejected()
        }
    }
    
    func launchTapped(launch: Space.Launch.Result) {
        router.navigateToInformation(launch: launch)
    }
    
}

extension RocketLaunchPresenter: RocketLaunchInteractorCallbackProtocol {
    
    func setLaunchList(launchList: [RocketLaunch.LaunchViewModel]) {
        if launchList.count > 0 {
            self.lastLaunchesSync = Date()
        }
        viewController.showLaunches(launchList: launchList)
    }
    
}
