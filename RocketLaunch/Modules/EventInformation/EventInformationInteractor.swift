//
//  EventInformationInteractor.swift
//  EventInformation
//
//  Created by Brais Castro on 26/12/21.
//

import UIKit
import CoreData

protocol EventInformationInteractorProtocol: BaseInteractorProtocol {

}

protocol EventInformationInteractorCallbackProtocol: BaseInteractorCallbackProtocol {

}

class EventInformationInteractor: BaseInteractor {

    weak var presenter: EventInformationInteractorCallbackProtocol!

    var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
}

extension EventInformationInteractor: EventInformationInteractorProtocol {

}
