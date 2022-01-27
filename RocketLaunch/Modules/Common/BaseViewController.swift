//
//  BaseViewController.swift
//  RocketLaunch
//
//  Created by Brais Castro on 24/12/21.
//

import UIKit
import AppLovinSDK

class BaseViewController: UIViewController {
    
    internal var adBannerPlaceholder: AdPlaceholderView!
    
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
    
    func setupAdBanner() {
        adBannerPlaceholder = AdPlaceholderView.shared
        adBannerPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(adBannerPlaceholder)
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationItem() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.init(named: "BackgroundColor")
    }
}
