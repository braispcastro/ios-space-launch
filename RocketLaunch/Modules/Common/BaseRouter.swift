//
//  BaseRouter.swift
//  RocketLaunch
//
//  Created by Brais Castro on 24/12/21.
//

import UIKit.UIViewController

public protocol BaseRouterProtocol: AnyObject {
    func navigateBack()
}

open class BaseRouter {
    
    unowned let viewController: UIViewController

    internal var navigationController: UINavigationController? {
        return viewController.navigationController
    }
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
}

extension BaseRouter: BaseRouterProtocol {
    
    public func navigateBack() {
        viewController.navigationController?.popViewController(animated: true)
    }
    
}
