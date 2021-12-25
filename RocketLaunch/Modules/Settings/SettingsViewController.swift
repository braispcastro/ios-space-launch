//
//  SettingsViewController.swift
//  Settings
//
//  Created by Brais Castro on 24/12/21.
//

import UIKit

final class SettingsViewController: BaseViewController {

    var presenter: SettingsPresenterProtocol!
    private var viewModel: Settings.ViewModel!

    // MARK: - Component Declaration

    private enum ViewTraits {
        static let margins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    public enum AccessibilityIds {
        static let view: String = "settings-view"
    }
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = "Settings"
        self.tabBarItem.image = UIImage(systemName: "ellipsis")
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

// MARK: - SettingsViewControllerProtocol

extension SettingsViewController: SettingsViewControllerProtocol {
    
    func show(viewModel: Settings.ViewModel) {
        self.viewModel = viewModel
        self.title = viewModel.title
    }
 
}
