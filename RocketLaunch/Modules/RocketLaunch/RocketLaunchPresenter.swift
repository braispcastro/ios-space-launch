//
//  RocketLaunchPresenter.swift
//  RocketLaunch
//
//  Created by Brais Castro on 24/12/21.
//

import Foundation

protocol RocketLaunchViewControllerProtocol: BaseViewControllerProtocol {
    func show(viewModel: RocketLaunch.ViewModel)
    func showLaunches(launchList: [RocketLaunch.Section])
}

protocol RocketLaunchPresenterProtocol: BasePresenterProtocol {
    func prepareView()
    func getLaunchesToShow()
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
        let launchList = [
            RocketLaunch.Section(title: "25-12-2021", rows: [
                RocketLaunch.Row(imageUrl: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/launch_images/soyuz2520stb2_image_20210520090021.jpeg",
                                 title: "Soyuz 2.1b/Fregat-M | OneWeb 12",
                                 provider: "Arianespace",
                                 pad: "31/6",
                                 windowStart: "27-12-2021 13:10:37",
                                 status: "Go for Launch"),
                RocketLaunch.Row(imageUrl: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/launch_images/soyuz2520stb2_image_20210520090021.jpeg",
                                 title: "Soyuz 2.1b/Fregat-M | OneWeb 12",
                                 provider: "Arianespace",
                                 pad: "31/6",
                                 windowStart: "27-12-2021 13:10:37",
                                 status: "Go for Launch")
            ]),
            RocketLaunch.Section(title: "26-12-2021", rows: [
                RocketLaunch.Row(imageUrl: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/launch_images/soyuz2520stb2_image_20210520090021.jpeg",
                                 title: "Soyuz 2.1b/Fregat-M | OneWeb 12",
                                 provider: "Arianespace",
                                 pad: "31/6",
                                 windowStart: "27-12-2021 13:10:37",
                                 status: "Go for Launch")
            ]),
            RocketLaunch.Section(title: "28-12-2021", rows: [
                RocketLaunch.Row(imageUrl: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/launch_images/soyuz2520stb2_image_20210520090021.jpeg",
                                 title: "Soyuz 2.1b/Fregat-M | OneWeb 12",
                                 provider: "Arianespace",
                                 pad: "31/6",
                                 windowStart: "27-12-2021 13:10:37",
                                 status: "Go for Launch"),
                RocketLaunch.Row(imageUrl: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/launch_images/soyuz2520stb2_image_20210520090021.jpeg",
                                 title: "Soyuz 2.1b/Fregat-M | OneWeb 12",
                                 provider: "Arianespace",
                                 pad: "31/6",
                                 windowStart: "27-12-2021 13:10:37",
                                 status: "Go for Launch"),
                RocketLaunch.Row(imageUrl: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/launch_images/soyuz2520stb2_image_20210520090021.jpeg",
                                 title: "Soyuz 2.1b/Fregat-M | OneWeb 12",
                                 provider: "Arianespace",
                                 pad: "31/6",
                                 windowStart: "27-12-2021 13:10:37",
                                 status: "Go for Launch")
            ]),
            RocketLaunch.Section(title: "30-12-2021", rows: [
                RocketLaunch.Row(imageUrl: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/launch_images/soyuz2520stb2_image_20210520090021.jpeg",
                                 title: "Soyuz 2.1b/Fregat-M | OneWeb 12",
                                 provider: "Arianespace",
                                 pad: "31/6",
                                 windowStart: "27-12-2021 13:10:37",
                                 status: "Go for Launch"),
                RocketLaunch.Row(imageUrl: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/launch_images/soyuz2520stb2_image_20210520090021.jpeg",
                                 title: "Soyuz 2.1b/Fregat-M | OneWeb 12",
                                 provider: "Arianespace",
                                 pad: "31/6",
                                 windowStart: "27-12-2021 13:10:37",
                                 status: "Go for Launch")
            ])
        ]
        viewController.showLaunches(launchList: launchList)
    }
    
}

extension RocketLaunchPresenter: RocketLaunchInteractorCallbackProtocol {
    
}
