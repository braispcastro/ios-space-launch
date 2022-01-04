//
//  EventsInteractor.swift
//  Events
//
//  Created by Brais Castro on 24/12/21.
//

import UIKit
import CoreData

protocol EventInteractorProtocol: BaseInteractorProtocol {
    func getEventList()
}

protocol EventInteractorCallbackProtocol: BaseInteractorCallbackProtocol {
    func setEventList(eventList: [Event.EventViewModel])
}

class EventInteractor: BaseInteractor {

    weak var presenter: EventInteractorCallbackProtocol!

    var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
}

extension EventInteractor: EventInteractorProtocol {
    
    func getEventList() {
        var eventList: [Event.EventViewModel] = []
        SpaceService.shared.events() { event in
            if let results = event.results {
                for result in results {
                    var stringEventDate = "-"
                    if let date = result.date {
                        if let eventDate = ISO8601DateFormatter().date(from: date) {
                            let formatter = DateFormatter()
                            formatter.dateStyle = .medium
                            formatter.timeStyle = .short
                            stringEventDate = formatter.string(from: eventDate)
                        }
                    }
                    eventList.append(Event.EventViewModel(imageUrl: result.featureImage,
                                                          name: result.name ?? "-",
                                                          location: result.location ?? "-",
                                                          type: result.type?.name ?? "-",
                                                          description: result.description ?? "-",
                                                          date: stringEventDate,
                                                          rawData: result))
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
