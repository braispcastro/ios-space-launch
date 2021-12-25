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
    private var eventList: [Events.Event] = []

    // MARK: - Component Declaration
    
    private var tableView: UITableView!

    private enum ViewTraits {
        static let margins = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: -15)
    }
    
    public enum AccessibilityIds {
        static let view: String = "events-view"
        static let tableView: String = "events-tableview"
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
        presenter.getEventsToShow()
    }

    // MARK: - Setup

    override func setupComponents() {
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: EventTableViewCell.kReuseIdentifier)
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    override func setupAccessibilityIdentifiers() {
        view.accessibilityIdentifier = AccessibilityIds.view
        tableView.accessibilityIdentifier = AccessibilityIds.tableView
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
    
    func showEvents(eventList: [Events.Event]) {
        self.eventList = eventList
        tableView.reloadData()
    }
 
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension EventsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return eventList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: EventTableViewCell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.kReuseIdentifier) as? EventTableViewCell else {
            fatalError("Not registered for tableView")
        }
        
        cell.mainImageView.kf.setImage(with: URL(string: eventList[indexPath.section].imageUrl))
        cell.nameLabel.text = eventList[indexPath.section].name
        cell.locationLabel.text = eventList[indexPath.section].location
        cell.typeLabel.text = eventList[indexPath.section].type
        cell.descriptionLabel.text = eventList[indexPath.section].description
        cell.dateLabel.text = eventList[indexPath.section].date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
