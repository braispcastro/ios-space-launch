//
//  BaseViewController.swift
//  RocketLaunch
//
//  Created by Brais Castro on 24/12/21.
//

import UIKit
import AppTrackingTransparency

class BaseViewController: UIViewController {
    
    static var firstTimeLaunched = true

    // MARK: - ViewLife Cycle
    /*
     Order:
     - viewDidLoad
     - viewWillAppear
     - viewDidAppear
     - viewWillDisapear
     - viewDidDisappear
     - viewWillLayoutSubviews
     - viewDidLayoutSubviews
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComponents()
        setupConstraints()
        setupAccessibilityIdentifiers()
        
        setupNavigationItem()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !BaseViewController.firstTimeLaunched {
            AdBannerManager.shared.rootViewController = self
        }
        BaseViewController.firstTimeLaunched = false
    }
    
    // MARK: - Setup
    
    func setupComponents() {
        fatalError("Missing implementation of \"setupComponents\"")
    }

    func setupConstraints() {
        fatalError("Missing implementation of \"setupConstraints\"")
    }
    
    func setupAccessibilityIdentifiers() {
        fatalError("Missing implementation of \"setupAccessibilityIdentifiers\"")
    }
    
    // MARK: - Public Methods
    
    func requestPermissionForAds(completionHandler: @escaping () -> Void) {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization() { status in
                completionHandler()
            }
        } else {
            completionHandler()
        }
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationItem() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.init(named: "BackgroundColor")
    }
}
