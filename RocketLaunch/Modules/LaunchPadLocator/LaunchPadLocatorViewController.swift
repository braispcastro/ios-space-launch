//
//  LaunchPadLocatorViewController.swift
//  RocketLaunch
//
//  Created by Brais Castro on 4/1/22.
//

import UIKit

final class LaunchPadLocatorViewController: BaseViewController {

    var presenter: LaunchPadLocatorPresenterProtocol!
    private var viewModel: LaunchPadLocator.ViewModel!

    // MARK: - Component Declaration

    private enum ViewTraits {
        static let margins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    public enum AccessibilityIds {
        
    }
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        //self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ViewLife Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.prepareView()
    }

    // MARK: - Setup

    override func setupComponents() {

    }

    override func setupConstraints() {

    }
    
    override func setupAccessibilityIdentifiers() {
        
    }

    // MARK: - Actions

    // MARK: Private Methods

}

// MARK: - LaunchPadLocatorViewControllerProtocol

extension LaunchPadLocatorViewController: LaunchPadLocatorViewControllerProtocol {
    
    func show(viewModel: LaunchPadLocator.ViewModel) {
        
    }
 
}
