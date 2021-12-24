//
//  SettingsPresenter.swift
//  Settings
//
//  Created by Brais Castro on 24/12/21.
//

import Foundation

protocol SettingsViewControllerProtocol: BaseViewControllerProtocol {
    func show(viewModel: Settings.ViewModel)
}

protocol SettingsPresenterProtocol: BasePresenterProtocol {
    func prepareView()
}

final class SettingsPresenter<T: SettingsViewControllerProtocol, U: SettingsRouterProtocol>: BasePresenter<T, U> {
    
    let interactor: SettingsInteractorProtocol
    
    init(viewController: T, router: U, interactor: SettingsInteractorProtocol) {
        self.interactor = interactor
        super.init(viewController: viewController, router: router)
    }
    
}

extension SettingsPresenter: SettingsPresenterProtocol {
    
    func prepareView() {
        let viewModel = Settings.ViewModel(title: "Settings")
        viewController.show(viewModel: viewModel)
    }
    
}

extension SettingsPresenter: SettingsInteractorCallbackProtocol {
    
}
