//
//  SettingsPresenter.swift
//  Settings
//
//  Created by Brais Castro on 24/12/21.
//

import Foundation
import UIKit.UIApplication
import AppTrackingTransparency
import UIKit

protocol SettingsViewControllerProtocol: BaseViewControllerProtocol {
    func show(viewModel: Settings.ViewModel)
}

protocol SettingsPresenterProtocol: BasePresenterProtocol {
    func prepareView()
    func configurationTapped(configType: Settings.ConfigType)
    func navigateToURI(uri: String)
}

final class SettingsPresenter<T: SettingsViewControllerProtocol, U: SettingsRouterProtocol>: BasePresenter<T, U> {
    
    let interactor: SettingsInteractorProtocol
    
    init(viewController: T, router: U, interactor: SettingsInteractorProtocol) {
        self.interactor = interactor
        super.init(viewController: viewController, router: router)
    }
    
    private func buildViewModel() -> Settings.ViewModel {
        let configRows = getConfigurationRows()
        let configSection = Settings.Section(title: "Configuration", rows: configRows)
        
        let aboutRows = getAboutRows()
        let aboutSection = Settings.Section(title: "About", rows: aboutRows)
        
        let viewModel = Settings.ViewModel(title: "Settings", sections: [configSection, aboutSection])
        return viewModel
    }
    
    private func getConfigurationRows() -> [Settings.Row] {
        var configRows: [Settings.Row] = []
        
        configRows.append(Settings.Row(title: "Appearance", subtitle: "Light, Dark, Default", enabled: true, uri: nil, configType: .appearance))
        
        let pushNotificationsSubtitle = "Tap to enable in device settings"
        configRows.append(Settings.Row(title: "Enable notifications", subtitle: pushNotificationsSubtitle, enabled: true, uri: UIApplication.openSettingsURLString, configType: nil))
        
        var allowTrackingEnabled = false
        var allowTrackingSubtitle = "Tracking is allowed"
        if #available(iOS 14, *) {
            if ATTrackingManager.trackingAuthorizationStatus != .authorized {
                allowTrackingEnabled = true
                allowTrackingSubtitle = "Tap to allow in device settings"
            }
        }
        configRows.append(Settings.Row(title: "Allow tracking", subtitle: allowTrackingSubtitle, enabled: allowTrackingEnabled, uri: UIApplication.openSettingsURLString, configType: nil))
        
        return configRows
    }
    
    private func getAboutRows() -> [Settings.Row] {
        var aboutRows: [Settings.Row] = []
        
        if let privacyPolicyURI = FirebaseRCService.shared.privacyPolicyURI {
            aboutRows.append(Settings.Row(title: "Privacy Policy", subtitle: "", enabled: true, uri: privacyPolicyURI, configType: nil))
        }
        
        if let termsOfUseURI = FirebaseRCService.shared.termsOfUseURI {
            aboutRows.append(Settings.Row(title: "Terms of Use", subtitle: "", enabled: true, uri: termsOfUseURI, configType: nil))
        }
        
        if let supportFormURI = FirebaseRCService.shared.supportFormURI {
            aboutRows.append(Settings.Row(title: "Support", subtitle: "", enabled: true, uri: supportFormURI, configType: nil))
        }
        
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            aboutRows.append(Settings.Row(title: "Version", subtitle: appVersion, enabled: false, uri: nil, configType: nil))
        }
        
        return aboutRows
    }
    
}

extension SettingsPresenter: SettingsPresenterProtocol {
    
    func prepareView() {
        let viewModel = buildViewModel()
        viewController.show(viewModel: viewModel)
    }
    
    func configurationTapped(configType: Settings.ConfigType) {
        switch configType {
        case .appearance:
            self.router.showSettingsDialog(title: "Appearance", configType: configType)
            break
        }
    }
    
    func navigateToURI(uri: String) {
        if let url = URL(string: uri) {
            UIApplication.shared.open(url)
        }
    }
    
}

extension SettingsPresenter: SettingsInteractorCallbackProtocol {
    
}
