//
//  SettingsViewController.swift
//  Settings
//
//  Created by Brais Castro on 24/12/21.
//

import UIKit

final class SettingsViewController: BaseViewController, AdBannerViewController {

    var presenter: SettingsPresenterProtocol!
    private var viewModel: Settings.ViewModel!

    // MARK: - Component Declaration
    
    internal var adBannerPlaceholder: AdPlaceholderView?
    
    private var tableView: UITableView!

    private enum ViewTraits {
        static let margins = UIEdgeInsets(top: 15, left: 15, bottom: -15, right: -15)
    }
    
    public enum AccessibilityIds {
        static let view: String = "settings-view"
        static let tableView: String = "settings-table-view"
    }
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = "Settings"
        self.tabBarItem.image = UIImage(systemName: "ellipsis")
        self.tabBarItem.selectedImage = UIImage(systemName: "ellipsis")
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
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        adBannerPlaceholder = AdPlaceholderView()
        adBannerPlaceholder!.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(adBannerPlaceholder!)
    }

    override func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            adBannerPlaceholder!.heightAnchor.constraint(equalToConstant: AdBannerManager.ViewTraits.adBannerHeight),
            adBannerPlaceholder!.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            adBannerPlaceholder!.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -self.tabBarController!.tabBar.frame.height),
            adBannerPlaceholder!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            adBannerPlaceholder!.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    override func setupAccessibilityIdentifiers() {
        view.accessibilityIdentifier = AccessibilityIds.view
        tableView.accessibilityIdentifier = AccessibilityIds.tableView
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

// MARK: - UITableViewDataSource, UITableViewDelegate

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderView()
        header.textLabel?.text = viewModel.sections[section].title
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.sections[indexPath.section].rows[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.separatorInset = UIEdgeInsets.zero
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.subtitle
        cell.isUserInteractionEnabled = item.enabled
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = viewModel.sections[indexPath.section].rows[indexPath.row]
        
        if let configType = item.configType {
            self.presenter.configurationTapped(configType: configType)
        } else if let uri = item.uri {
            self.presenter.navigateToURI(uri: uri)
        }
    }
    
}
