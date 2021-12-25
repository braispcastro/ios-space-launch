//
//  EventsViewController.swift
//  Events
//
//  Created by Brais Castro on 24/12/21.
//

import UIKit

final class EventsViewController: BaseViewController {

    var presenter: EventsPresenterProtocol!
    private var viewModel: Events.ViewModel!

    // MARK: - Component Declaration

    private enum ViewTraits {
        static let margins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    public enum AccessibilityIds {
        static let view: String = "events-view"
    }
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = "Events"
        self.tabBarItem.image = UIImage(systemName: "calendar")
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

// MARK: - EventsViewControllerProtocol

extension EventsViewController: EventsViewControllerProtocol {
    
    func show(viewModel: Events.ViewModel) {
        self.viewModel = viewModel
        self.title = viewModel.title
    }
 
}
