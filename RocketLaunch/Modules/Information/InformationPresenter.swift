//
//  InformationPresenter.swift
//  Information
//
//  Created by Brais Castro on 26/12/21.
//

import Foundation

protocol InformationViewControllerProtocol: BaseViewControllerProtocol {
    func show(viewModel: Information.ViewModel)
}

protocol InformationPresenterProtocol: BasePresenterProtocol {
    func prepareView()
    func padCellTapped(pad: Information.Pad)
}

final class InformationPresenter<T: InformationViewControllerProtocol, U: InformationRouterProtocol>: BasePresenter<T, U> {
    
    let fullLaunch: Space.Launch.Result
    
    init(viewController: T,
         router: U,
         launch: Space.Launch.Result) {
        self.fullLaunch = launch
        super.init(viewController: viewController, router: router)
    }
    
    private func buildViewModel() -> Information.ViewModel {
        var sections: [Information.InformationType] = []
        
        sections.append(Information.InformationType.launch)
        let launch = Information.Launch(imageUrl: fullLaunch.image,
                                                    rocket: fullLaunch.rocket?.configuration?.name ?? "-",
                                                    mission: fullLaunch.mission?.name ?? "-",
                                                    provider: fullLaunch.launchServiceProvider?.name ?? "-",
                                                    pad: fullLaunch.pad?.name ?? "-",
                                                    windowStart: fullLaunch.windowStart ?? "-",
                                                    status: fullLaunch.status?.name ?? "-",
                                                    statusType: fullLaunch.status?.type ?? .unknown)
        
        var provider: Information.Provider?
        if let rawProvider = fullLaunch.launchServiceProvider {
            sections.append(Information.InformationType.provider)
            provider = Information.Provider(logoUrl: rawProvider.logoUrl,
                                                        name: rawProvider.name ?? "-",
                                                        description: rawProvider.description ?? "-",
                                                        countryCode: rawProvider.countryCode ?? "-",
                                                        foundingYear: rawProvider.foundingYear ?? "-",
                                                        infoUrl: rawProvider.infoUrl,
                                                        wikiUrl: rawProvider.wikiUrl)
        }
        
        var mission: Information.Mission?
        if let rawMission = fullLaunch.mission {
            sections.append(Information.InformationType.mission)
            mission = Information.Mission(logoUrl: fullLaunch.missionPatches?.first?.imageUrl,
                                                      name: rawMission.name ?? "-",
                                                      type: rawMission.type ?? "-",
                                                      description: rawMission.description ?? "-")
        }
        
        var pad: Information.Pad?
        if let rawPad = fullLaunch.pad {
            sections.append(Information.InformationType.pad)
            pad = Information.Pad(name: rawPad.name ?? "-",
                                              location: rawPad.location?.name ?? "-",
                                              latitude: rawPad.latitude,
                                              longitude: rawPad.longitude)
        }
        
        return Information.ViewModel(title: "Information",
                                                 sections: sections,
                                                 launch: launch,
                                                 provider: provider,
                                                 mission: mission,
                                                 pad: pad)
    }
    
}

extension InformationPresenter: InformationPresenterProtocol {
    
    func prepareView() {
        let viewModel = buildViewModel()
        viewController.show(viewModel: viewModel)
    }
    
    func padCellTapped(pad: Information.Pad) {
        if let latitude = pad.latitude, let longitude = pad.longitude {
            router.navigateToLaunchPadLocator(name: pad.name, lat: latitude, lon: longitude)
        }
    }
    
}
