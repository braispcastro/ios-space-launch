//
//  RocketLaunchInteractor.swift
//  RocketLaunch
//
//  Created by Brais Castro on 24/12/21.
//

import UIKit
import CoreData

protocol RocketLaunchInteractorProtocol: BaseInteractorProtocol {
    func getLaunchList()
}

protocol RocketLaunchInteractorCallbackProtocol: BaseInteractorCallbackProtocol {
    func setLaunchList(launchList: [RocketLaunch.LaunchViewModel])
}

class RocketLaunchInteractor: BaseInteractor {

    weak var presenter: RocketLaunchInteractorCallbackProtocol!

    var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
}

extension RocketLaunchInteractor: RocketLaunchInteractorProtocol {
    
    func getLaunchList() {
        var launchList: [RocketLaunch.LaunchViewModel] = []
        SpaceService.shared.launches() { launch in
            if let results = launch.results {
                for result in results {
                    launchList.append(RocketLaunch.LaunchViewModel(imageUrl: result.image ?? Constants.kRocketLaunchPlaceholderImage,
                                                                   rocket: result.rocket?.configuration?.name ?? "-",
                                                                   mission: result.mission?.name ?? "-",
                                                                   provider: result.launchServiceProvider?.name ?? "-",
                                                                   pad: result.pad?.name ?? "-",
                                                                   windowStart: result.windowStart ?? "-",
                                                                   status: result.status?.name ?? "-",
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
