//
//  RocketLaunchViewController.swift
//  RocketLaunch
//
//  Created by Brais Castro on 24/12/21.
//

import UIKit
import Kingfisher

final class RocketLaunchViewController: BaseViewController {

    var presenter: RocketLaunchPresenterProtocol!
    private var viewModel: RocketLaunch.ViewModel!
    private var launchList: [RocketLaunch.Section] = []

    // MARK: - Component Declaration
    
    private var tableView: UITableView!

    private enum ViewTraits {
        static let margins = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: -15)
    }
    
    public enum AccessibilityIds {
        static let view: String = "rocket-launch-view"
        static let tableView: String = "rocket-launch-tableview"
    }
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = "Launches"
        self.tabBarItem.image = UIImage(systemName: "paperplane")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ViewLife Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.prepareView()
        presenter.getLaunchesToShow()
    }

    // MARK: - Setup

    override func setupComponents() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: HeaderView.kReuseIdentifier)
        tableView.register(RocketLaunchTableViewCell.self, forCellReuseIdentifier: RocketLaunchTableViewCell.kReuseIdentifier)
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

// MARK: - RocketLaunchViewControllerProtocol

extension RocketLaunchViewController: RocketLaunchViewControllerProtocol {
    
    func show(viewModel: RocketLaunch.ViewModel) {
        self.viewModel = viewModel
        self.title = viewModel.title
    }
    
    func showLaunches(launchList: [RocketLaunch.Section]) {
        self.launchList = launchList
        tableView.reloadData()
    }
 
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension RocketLaunchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return launchList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView: HeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.kReuseIdentifier) as? HeaderView else {
            fatalError("Not registered for tableView")
        }
        
        headerView.textLabel?.text = launchList[section].title
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launchList[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: RocketLaunchTableViewCell = tableView.dequeueReusableCell(withIdentifier: RocketLaunchTableViewCell.kReuseIdentifier) as? RocketLaunchTableViewCell else {
            fatalError("Not registered for tableView")
        }
        
        cell.titleLabel.text = launchList[indexPath.section].rows[indexPath.row].title
        cell.providerLabel.text = launchList[indexPath.section].rows[indexPath.row].provider
        cell.padLabel.text = launchList[indexPath.section].rows[indexPath.row].pad
        cell.windowStartLabel.text = launchList[indexPath.section].rows[indexPath.row].windowStart
        cell.statusLabel.text = launchList[indexPath.section].rows[indexPath.row].status
        cell.mainImageView.kf.setImage(with: URL(string: launchList[indexPath.section].rows[indexPath.row].imageUrl))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
