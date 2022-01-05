//
//  NavigationController.swift
//  RocketLaunch
//
//  Created by Castro, Brais on 5/1/22.
//

import UIKit

class NavigationController: UINavigationController {

    // MARK: - Init
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupNavigationController()
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setupNavigationController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNavigationController() {
        let backButtonImage = UIImage(systemName: "arrow.backward")
        self.navigationBar.backIndicatorImage = backButtonImage
        self.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        self.navigationBar.prefersLargeTitles = true
    }

}

extension UINavigationController {
    
    public func pushViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    
    public func popViewController(animated: Bool, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }
    
}
