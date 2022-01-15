//
//  SettingsDialogPresenter.swift
//  RocketLaunch
//
//  Created by Brais Castro on 15/1/22.
//

import Foundation
import UIKit

protocol SettingsDialogViewControllerProtocol: BaseViewControllerProtocol {
    func show(viewModel: SettingsDialog.ViewModel)
    func changeInterfaceStyle(style: UIUserInterfaceStyle)
}

protocol SettingsDialogPresenterProtocol: BasePresenterProtocol {
    func prepareView()
}

final class SettingsDialogPresenter<T: SettingsDialogViewControllerProtocol, U: SettingsDialogRouterProtocol>: BasePresenter<T, U> {

    let title: String
    let configType: Settings.ConfigType
    
    init(viewController: T, router: U, title: String, configType: Settings.ConfigType) {
        self.title = title
        self.configType = configType
        super.init(viewController: viewController, router: router)
    }
    
    private func buildDialogForAppearance() -> SettingsDialog.ViewModel {
        let interfaceStyle = UserDefaultsManager.string(key: .interfaceStyle)
        
        let defaultStyle = SettingsDialog.Row(title: "Default", selected: interfaceStyle == "Default") {
            UserDefaultsManager.set(key: .interfaceStyle, value: "Default")
            self.viewController.changeInterfaceStyle(style: .unspecified)
            self.prepareView()
        }
        let lightStyle = SettingsDialog.Row(title: "Light", selected: interfaceStyle == "Light") {
            UserDefaultsManager.set(key: .interfaceStyle, value: "Light")
            self.viewController.changeInterfaceStyle(style: .light)
            self.prepareView()
        }
        let darkStyle = SettingsDialog.Row(title: "Dark", selected: interfaceStyle == "Dark") {
            UserDefaultsManager.set(key: .interfaceStyle, value: "Dark")
            self.viewController.changeInterfaceStyle(style: .dark)
            self.prepareView()
        }
        
        return SettingsDialog.ViewModel(title: title,
                                        settingsType: configType,
                                        rows: [defaultStyle, lightStyle, darkStyle])
    }
    
}

extension SettingsDialogPresenter: SettingsDialogPresenterProtocol {
    
    func prepareView() {
        switch configType {
        case .appearance:
            let viewModel = buildDialogForAppearance()
            viewController.show(viewModel: viewModel)
        }
    }
    
}
