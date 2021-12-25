//
//  RocketLaunchInteractor.swift
//  RocketLaunch
//
//  Created by Brais Castro on 24/12/21.
//

import UIKit
import CoreData

protocol RocketLaunchInteractorProtocol: BaseInteractorProtocol {
    func getMockedLaunchList()
    func getLaunchList()
}

protocol RocketLaunchInteractorCallbackProtocol: BaseInteractorCallbackProtocol {
    func setMockedLaunchList(launchList: [RocketLaunch.Launch])
}

class RocketLaunchInteractor: BaseInteractor {

    weak var presenter: RocketLaunchInteractorCallbackProtocol!

    var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
}

extension RocketLaunchInteractor: RocketLaunchInteractorProtocol {

    func getMockedLaunchList() {
        let launchList = [
                RocketLaunch.Launch(imageUrl: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/launch_images/soyuz2520stb2_image_20210520090021.jpeg",
                                    rocket: "Soyuz 2.1b/Fregat-M",
                                    mission: "OneWeb 12",
                                    provider: "Arianespace",
                                    pad: "31/6",
                                    windowStart: "27-12-2021 13:10:37",
                                    status: "Go for Launch"),
                RocketLaunch.Launch(imageUrl: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/launch_images/soyuz2520stb2_image_20210520090021.jpeg",
                                    rocket: "Soyuz 2.1b/Fregat-M",
                                    mission: "OneWeb 12",
                                    provider: "Arianespace",
                                    pad: "31/6",
                                    windowStart: "27-12-2021 13:10:37",
                                    status: "Go for Launch"),
                RocketLaunch.Launch(imageUrl: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/launch_images/soyuz2520stb2_image_20210520090021.jpeg",
                                    rocket: "Soyuz 2.1b/Fregat-M",
                                    mission: "OneWeb 12",
                                    provider: "Arianespace",
                                    pad: "31/6",
                                    windowStart: "27-12-2021 13:10:37",
                                    status: "Go for Launch"),
                RocketLaunch.Launch(imageUrl: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/launch_images/soyuz2520stb2_image_20210520090021.jpeg",
                                    rocket: "Soyuz 2.1b/Fregat-M",
                                    mission: "OneWeb 12",
                                    provider: "Arianespace",
                                    pad: "31/6",
                                    windowStart: "27-12-2021 13:10:37",
                                    status: "Go for Launch"),
                RocketLaunch.Launch(imageUrl: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/launch_images/soyuz2520stb2_image_20210520090021.jpeg",
                                    rocket: "Soyuz 2.1b/Fregat-M",
                                    mission: "OneWeb 12",
                                    provider: "Arianespace",
                                    pad: "31/6",
                                    windowStart: "27-12-2021 13:10:37",
                                    status: "Go for Launch"),
                RocketLaunch.Launch(imageUrl: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/launch_images/soyuz2520stb2_image_20210520090021.jpeg",
                                    rocket: "Soyuz 2.1b/Fregat-M",
                                    mission: "OneWeb 12",
                                    provider: "Arianespace",
                                    pad: "31/6",
                                    windowStart: "27-12-2021 13:10:37",
                                    status: "Go for Launch"),
                RocketLaunch.Launch(imageUrl: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/launch_images/soyuz2520stb2_image_20210520090021.jpeg",
                                    rocket: "Soyuz 2.1b/Fregat-M",
                                    mission: "OneWeb 12",
                                    provider: "Arianespace",
                                    pad: "31/6",
                                    windowStart: "27-12-2021 13:10:37",
                                    status: "Go for Launch"),
                RocketLaunch.Launch(imageUrl: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/launch_images/soyuz2520stb2_image_20210520090021.jpeg",
                                    rocket: "Soyuz 2.1b/Fregat-M",
                                    mission: "OneWeb 12",
                                    provider: "Arianespace",
                                    pad: "31/6",
                                    windowStart: "27-12-2021 13:10:37",
                                    status: "Go for Launch")
        ]
        
        presenter.setMockedLaunchList(launchList: launchList)
    }
    
    func getLaunchList() {
        var launchList: [RocketLaunch.Launch] = []
        SpaceService.shared.launches() { launch in
            if let results = launch.results {
                for result in results {
                    launchList.append(RocketLaunch.Launch(imageUrl: result.image,
                                                          rocket: result.rocket?.configuration?.name,
                                                          mission: result.mission?.name,
                                                          provider: result.launchServiceProvider?.name,
                                                          pad: result.pad?.name,
                                                          windowStart: "result.windowStart",
                                                          status: result.status?.name))
                }
            }
        } failure: { error in
            if let error = error {
                print(error)
            }
        }
        
    }
    
}
