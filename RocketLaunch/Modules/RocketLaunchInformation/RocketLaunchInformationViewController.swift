//
//  RocketLaunchInformationViewController.swift
//  RocketLaunchInformation
//
//  Created by Brais Castro on 26/12/21.
//

import UIKit

final class RocketLaunchInformationViewController: BaseViewController {

    var presenter: RocketLaunchInformationPresenterProtocol!
    private var viewModel: RocketLaunchInformation.ViewModel!

    // MARK: - Component Declaration

    private enum ViewTraits {
        static let margins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    public enum AccessibilityIds {
        static let view: String = "rocket-launch-information-view"
    }
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
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
        view.accessibilityIdentifier = AccessibilityIds.view
    }

    // MARK: - Actions

    // MARK: Private Methods

}

// MARK: - RocketLaunchInformationViewControllerProtocol

extension RocketLaunchInformationViewController: RocketLaunchInformationViewControllerProtocol {
    
    func show(viewModel: RocketLaunchInformation.ViewModel) {
        self.viewModel = viewModel
        self.title = viewModel.title
    }
 
}
