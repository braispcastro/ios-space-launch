//
//  EventsInteractor.swift
//  Events
//
//  Created by Brais Castro on 24/12/21.
//

import UIKit
import CoreData

protocol EventsInteractorProtocol: BaseInteractorProtocol {

}

protocol EventsInteractorCallbackProtocol: BaseInteractorCallbackProtocol {

}

class EventsInteractor: BaseInteractor {

    weak var presenter: EventsInteractorCallbackProtocol!

    var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
}

extension EventsInteractor: EventsInteractorProtocol {

}
