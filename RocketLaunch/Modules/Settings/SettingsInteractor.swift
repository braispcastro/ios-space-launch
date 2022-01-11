//
//  SettingsInteractor.swift
//  Settings
//
//  Created by Brais Castro on 24/12/21.
//

import UIKit
import CoreData

protocol SettingsInteractorProtocol: BaseInteractorProtocol {

}

protocol SettingsInteractorCallbackProtocol: BaseInteractorCallbackProtocol {

}

class SettingsInteractor: BaseInteractor {

    weak var presenter: SettingsInteractorCallbackProtocol!

    var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
}

extension SettingsInteractor: SettingsInteractorProtocol {

}
