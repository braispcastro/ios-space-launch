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
    let fullLaunch: Space.Launch.Result
    
    init(viewController: T,
         router: U,
         interactor: RocketLaunchInformationInteractorProtocol,
         launch: Space.Launch.Result) {
        self.interactor = interactor
        self.fullLaunch = launch
        super.init(viewController: viewController, router: router)
    }
    
    private func buildViewModel() -> RocketLaunchInformation.ViewModel {
        var sections: [RocketLaunchInformation.InformationType] = []
        
        sections.append(RocketLaunchInformation.InformationType.launch)
        let launch = RocketLaunchInformation.Launch(imageUrl: fullLaunch.image,
                                                    rocket: fullLaunch.rocket?.configuration?.name ?? "-",
                                                    mission: fullLaunch.mission?.name ?? "-",
                                                    provider: fullLaunch.launchServiceProvider?.name ?? "-",
                                                    pad: fullLaunch.pad?.name ?? "-",
                                                    windowStart: fullLaunch.windowStart ?? "-",
                                                    status: fullLaunch.status?.name ?? "-")
        
        var provider: RocketLaunchInformation.Provider?
        if let rawProvider = fullLaunch.launchServiceProvider {
            sections.append(RocketLaunchInformation.InformationType.provider)
            provider = RocketLaunchInformation.Provider(logoUrl: rawProvider.logoUrl,
                                                        name: rawProvider.name ?? "-",
                                                        description: rawProvider.description ?? "-",
                                                        countryCode: rawProvider.countryCode ?? "-",
                                                        foundingYear: rawProvider.foundingYear ?? "-",
                                                        infoUrl: rawProvider.infoUrl,
                                                        wikiUrl: rawProvider.wikiUrl)
        }
        
        var mission: RocketLaunchInformation.Mission?
        if let rawMission = fullLaunch.mission {
            sections.append(RocketLaunchInformation.InformationType.mission)
            mission = RocketLaunchInformation.Mission(logoUrl: fullLaunch.missionPatches?.first?.imageUrl,
                                                      name: rawMission.name ?? "-",
                                                      type: rawMission.type ?? "-",
                                                      description: rawMission.description ?? "-")
        }
        
        var pad: RocketLaunchInformation.Pad?
        if let rawPad = fullLaunch.pad {
            sections.append(RocketLaunchInformation.InformationType.pad)
            pad = RocketLaunchInformation.Pad(name: rawPad.name ?? "-",
                                              location: rawPad.location?.name ?? "-",
                                              latitude: rawPad.latitude,
                                              longitude: rawPad.longitude)
        }
        
        return RocketLaunchInformation.ViewModel(title: "Information",
                                                 sections: sections,
                                                 launch: launch,
                                                 provider: provider,
                                                 mission: mission,
                                                 pad: pad)
    }
    
}

extension RocketLaunchInformationPresenter: RocketLaunchInformationPresenterProtocol {
    
    func prepareView() {
        let viewModel = buildViewModel()
        viewController.show(viewModel: viewModel)
    }
    
}

extension RocketLaunchInformationPresenter: RocketLaunchInformationInteractorCallbackProtocol {
    
}
