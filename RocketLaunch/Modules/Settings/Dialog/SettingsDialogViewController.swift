//
//  SettingsDialogViewController.swift
//  RocketLaunch
//
//  Created by Brais Castro on 15/1/22.
//

import UIKit

final class SettingsDialogViewController: BaseViewController {

    var presenter: SettingsDialogPresenterProtocol!
    private var viewModel: SettingsDialog.ViewModel!

    // MARK: - Component Declaration
    
    private var titleLabel: UILabel!
    private var tableView: UITableView!

    private enum ViewTraits {
        static let margins = UIEdgeInsets(top: 30, left: 15, bottom: -30, right: -15)
        static let buttonMargins = UIEdgeInsets(top: 30, left: 60, bottom: -30, right: -60)
        static let buttonHeight = CGFloat(50)
    }
    
    public enum AccessibilityIds {
        static let view: String = "settings-dialog-view"
        static let titleLabel: String = "settings-dialog-title-label"
        static let tableView: String = "settings-dialog-table-view"
    }

    // MARK: - ViewLife Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.prepareView()
    }

    // MARK: - Setup

    override func setupComponents() {
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        view.addSubview(titleLabel)
        
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: ViewTraits.margins.top),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ViewTraits.margins.left),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ViewTraits.margins.right),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: ViewTraits.margins.top),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: ViewTraits.buttonMargins.bottom),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    override func setupAccessibilityIdentifiers() {
        view.accessibilityIdentifier = AccessibilityIds.view
        titleLabel.accessibilityIdentifier = AccessibilityIds.titleLabel
        tableView.accessibilityIdentifier = AccessibilityIds.tableView
    }

    // MARK: - Actions
    
    @objc private func dismissButtonTapped() {
        self.dismiss(animated: true)
    }

    // MARK: Private Methods

}

// MARK: - SettingsDialogViewControllerProtocol

extension SettingsDialogViewController: SettingsDialogViewControllerProtocol {
 
    func show(viewModel: SettingsDialog.ViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        tableView.reloadData()
    }
    
    func changeInterfaceStyle(style: UIUserInterfaceStyle) {
        view.window?.overrideUserInterfaceStyle = style
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension SettingsDialogViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.rows[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.selectionStyle = .none
        cell.textLabel?.text = item.title
        if item.selected {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.rows[indexPath.row]
        item.action()
    }
    
}
