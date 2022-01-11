//
//  BasePresenter.swift
//  RocketLaunch
//
//  Created by Brais Castro on 24/12/21.
//

import UIKit.UIApplication

public protocol BaseViewControllerProtocol: AnyObject {
    
}

public extension BaseViewControllerProtocol {
    
}

public protocol BasePresenterProtocol: AnyObject {
}

public class BasePresenter<T: BaseViewControllerProtocol, U: BaseRouterProtocol>: BasePresenterProtocol {
    
    unowned let viewController: T
    let router: U
    
    init(viewController: T, router: U) {
        self.viewController = viewController
        self.router = router
    }

}

public enum BasePresenterLocalizationKeys {
    
}
