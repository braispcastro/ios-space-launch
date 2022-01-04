//
//  LaunchPadLocatorPresenter.swift
//  RocketLaunch
//
//  Created by Brais Castro on 4/1/22.
//

import Foundation

protocol LaunchPadLocatorViewControllerProtocol: BaseViewControllerProtocol {
    func show(viewModel: LaunchPadLocator.ViewModel)
}

protocol LaunchPadLocatorPresenterProtocol: BasePresenterProtocol {
    func prepareView()
}

final class LaunchPadLocatorPresenter<T: LaunchPadLocatorViewControllerProtocol, U: LaunchPadLocatorRouterProtocol>: BasePresenter<T, U> {
    
    var name: String
    var latitude: String
    var longitude: String

    init(viewController: T,
         router: U,
         name: String,
         latitude: String,
         longitude: String) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        super.init(viewController: viewController, router: router)
    }
    
}

extension LaunchPadLocatorPresenter: LaunchPadLocatorPresenterProtocol {

    func prepareView() {
        let viewModel = LaunchPadLocator.ViewModel(launchPadName: name,
                                                   latitude: latitude,
                                                   longitude: longitude)
        viewController.show(viewModel: viewModel)
    }
    
}
