//
//  RocketLaunchInteractor.swift
//  RocketLaunch
//
//  Created by Brais Castro on 24/12/21.
//

import UIKit
import CoreData
import GoogleMobileAds

protocol RocketLaunchInteractorProtocol: BaseInteractorProtocol {
    func getLaunchList()
}

protocol RocketLaunchInteractorCallbackProtocol: BaseInteractorCallbackProtocol {
    func setLaunchList(launchList: [LaunchListProtocol])
}

class RocketLaunchInteractor: BaseInteractor {

    weak var presenter: RocketLaunchInteractorCallbackProtocol!

    var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
}

extension RocketLaunchInteractor: RocketLaunchInteractorProtocol {
    
    func getLaunchList() {
        var counter = 0
        var launchList: [LaunchListProtocol] = []
        SpaceService.shared.launches() { launch in
            if let results = launch.results {
                for result in results {
                    counter += 1
                    if counter == 3 {
                        launchList.append(RocketLaunch.GoogleNativeAd())
                    } else if counter == 4 {
                        counter = 0
                    }
                    
                    launchList.append(RocketLaunch.LaunchViewModel(imageUrl: result.image,
                                                                   rocket: result.rocket?.configuration?.name ?? "-",
                                                                   mission: result.mission?.name ?? "-",
                                                                   provider: result.launchServiceProvider?.name ?? "-",
                                                                   pad: result.pad?.name ?? "-",
                                                                   windowStart: result.windowStart ?? "-",
                                                                   status: result.status?.name ?? "-",
                                                                   statusType: result.status?.type ?? .unknown,
                                                                   rawData: result))
                }
            }
            self.presenter.setLaunchList(launchList: launchList)
        } failure: { error in
            if let error = error {
                print(error)
            }
        }
    }
    
}
