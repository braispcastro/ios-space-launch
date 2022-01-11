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
    
    func buildViewModel() -> Settings.ViewModel {
        
        let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        let aboutSection = Settings.Section(title: "About", rows: [
            Settings.Row(title: "Application", subtitle: "Rocket Launch Calendar", enabled: false),
            Settings.Row(title: "Developer", subtitle: "Brais Castro", enabled: false),
            Settings.Row(title: "Version", subtitle: appVersion, enabled: false)
        ])
        
        let viewModel = Settings.ViewModel(title: "Settings", sections: [aboutSection])
        return viewModel
    }
    
}

extension SettingsPresenter: SettingsPresenterProtocol {
    
    func prepareView() {
        let viewModel = buildViewModel()
        viewController.show(viewModel: viewModel)
    }
    
}

extension SettingsPresenter: SettingsInteractorCallbackProtocol {
    
}
