//
//  RocketLaunchInformationInteractor.swift
//  RocketLaunchInformation
//
//  Created by Brais Castro on 26/12/21.
//

import UIKit
import CoreData

protocol RocketLaunchInformationInteractorProtocol: BaseInteractorProtocol {

}

protocol RocketLaunchInformationInteractorCallbackProtocol: BaseInteractorCallbackProtocol {

}

class RocketLaunchInformationInteractor: BaseInteractor {

    weak var presenter: RocketLaunchInformationInteractorCallbackProtocol!

    var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
}

extension RocketLaunchInformationInteractor: RocketLaunchInformationInteractorProtocol {

}
