//
//  SplashViewController.swift
//  RocketLaunch
//
//  Created by Castro, Brais on 27/1/22.
//

import UIKit
import AdSupport
import AppTrackingTransparency
import FirebaseMessaging
import GoogleMobileAds

class SplashViewController: UIViewController {
    
    internal var rocketImage: UIImageView!
    
    private enum ViewTraits {
        static let margins = UIEdgeInsets(top: 0, left: 72, bottom: 0, right: -72)
    }

    // MARK: - ViewLife Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupComponents()
        setupConstraints()
        
        setupApp()
    }
    
    // MARK: - Private Methods
    
    private func setupComponents() {
        view.backgroundColor = UIColor.init(named: "AccentColor")
        
        rocketImage = UIImageView()
        rocketImage.translatesAutoresizingMaskIntoConstraints = false
        rocketImage.image = UIImage(named: "Rocket")
        view.addSubview(rocketImage)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            rocketImage.heightAnchor.constraint(equalTo: rocketImage.widthAnchor),
            rocketImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rocketImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rocketImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ViewTraits.margins.left),
            rocketImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ViewTraits.margins.right)
        ])
    }
    
    private func setupApp() {
        // Firebase configuration
        FirebaseRCService.shared.fetch() {
            self.requestPermissionForAds {
                DispatchQueue.main.async {
                    // Init AppLovin SDK
                    GADMobileAds.sharedInstance().start { _ in
                        self.requestPushNotificationsPermission {
                            DispatchQueue.main.async {
                                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                let vc = self.setupTabBarController()
                                appDelegate.window?.rootViewController = vc
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func requestPermissionForAds(completionHandler: @escaping () -> Void) {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization() { status in
                completionHandler()
            }
        } else {
            completionHandler()
        }
    }
    
    private func requestPushNotificationsPermission(completionHandler: @escaping () -> Void) {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { granted, error in
            guard granted else {
                completionHandler()
                return
            }
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                guard settings.authorizationStatus == .authorized else {
                    completionHandler()
                    return
                }
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                    #if DEBUG
                    Messaging.messaging().unsubscribe(fromTopic: "production")
                    Messaging.messaging().subscribe(toTopic: "development")
                    #else
                    Messaging.messaging().unsubscribe(fromTopic: "development")
                    Messaging.messaging().subscribe(toTopic: "production")
                    #endif
                    completionHandler()
                }
            }
        }
    }
    
    private func setupTabBarController() -> UITabBarController {
        let rocketLaunch = RocketLaunchBuilder.build()
        let events = EventBuilder.build()
        let settings = SettingsBuilder.build()
        
        let bottomNavigator = UITabBarController()
        bottomNavigator.setViewControllers([rocketLaunch, events, settings], animated: true)
        
        return bottomNavigator
    }

}
