//
//  EventsInteractor.swift
//  Events
//
//  Created by Brais Castro on 24/12/21.
//

import UIKit
import CoreData

protocol EventsInteractorProtocol: BaseInteractorProtocol {
    func getEventList()
}

protocol EventsInteractorCallbackProtocol: BaseInteractorCallbackProtocol {
    func setEventList(eventList: [Events.Event])
}

class EventsInteractor: BaseInteractor {

    weak var presenter: EventsInteractorCallbackProtocol!

    var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
}

extension EventsInteractor: EventsInteractorProtocol {
    
    func getEventList() {
        var eventList: [Events.Event] = []
        SpaceService.shared.events() { event in
            if let results = event.results {
                for result in results {
                    eventList.append(Events.Event(imageUrl: result.featureImage ?? Constants.kEventPlaceholderImage,
                                                  name: result.name ?? "-",
                                                  location: result.location ?? "-",
                                                  type: result.type?.name ?? "-",
                                                  description: result.description ?? "-",
                                                  date: result.date ?? "-"))
                }
            }
            self.presenter.setEventList(eventList: eventList)
        } failure: { error in
            if let error = error {
                print(error)
            }
        }
    }

}
