//
//  AppDelegate.swift
//  RocketLaunch
//
//  Created by Brais Castro on 24/12/21.
//

import UIKit
import CoreData
import AppLovinSDK
import Firebase
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = setupTabBarController()
        self.window?.makeKeyAndVisible()
        
        application.registerForRemoteNotifications()
        
        configureLibraries()
        configureVisualStyle()
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        FirebaseRCService.shared.fetch() {
            // Do nothing...
        }
    }
    
    // MARK: - Private Methods
    
    private func setupTabBarController() -> UITabBarController {
        let rocketLaunch = RocketLaunchBuilder.build()
        let events = EventBuilder.build()
        let settings = SettingsBuilder.build()
        
        let bottomNavigator = UITabBarController()
        bottomNavigator.setViewControllers([rocketLaunch, events, settings], animated: true)
        
        return bottomNavigator
    }
    
    private func configureVisualStyle() {
        guard let interfaceStyle = UserDefaultsManager.string(key: .interfaceStyle) else {
            UserDefaultsManager.set(key: .interfaceStyle, value: "Default")
            return
        }
        
        switch interfaceStyle {
        case "Light":
            window?.overrideUserInterfaceStyle = .light
            break
        case "Dark":
            window?.overrideUserInterfaceStyle = .dark
            break
        default:
            window?.overrideUserInterfaceStyle = .unspecified
            break
        }
    }
    
    private func configureLibraries() {
        // Firebase
        FirebaseApp.configure()
        
        // Push notifications
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "RocketLaunch")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

// MARK: - UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Token: \(token)")
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
}

// MARK: - MessagingDelegate
extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        if let fcmToken = fcmToken {
            print("FCMToken: \(fcmToken)")
        }
    }
    
}
