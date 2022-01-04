//
//  InformationInteractor.swift
//  Information
//
//  Created by Brais Castro on 26/12/21.
//

import UIKit
import CoreData

protocol InformationInteractorProtocol: BaseInteractorProtocol {

}

protocol InformationInteractorCallbackProtocol: BaseInteractorCallbackProtocol {

}

class InformationInteractor: BaseInteractor {

    weak var presenter: InformationInteractorCallbackProtocol!

    var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
}

extension InformationInteractor: InformationInteractorProtocol {

}
