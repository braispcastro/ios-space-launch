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
    
    private var tableView: UITableView!

    private enum ViewTraits {
        static let margins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    public enum AccessibilityIds {
        static let view: String = "rocket-launch-information-view"
        static let tableView: String = "rocket-launch-information-tableview"
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
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(RocketLaunchTableViewCell.self, forCellReuseIdentifier: RocketLaunchTableViewCell.kReuseIdentifier)
        tableView.register(ProviderTableViewCell.self, forCellReuseIdentifier: ProviderTableViewCell.kReuseIdentifier)
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

// MARK: - RocketLaunchInformationViewControllerProtocol

extension RocketLaunchInformationViewController: RocketLaunchInformationViewControllerProtocol {
    
    func show(viewModel: RocketLaunchInformation.ViewModel) {
        self.viewModel = viewModel
        self.title = viewModel.title
    }
    
    func getLaunchCell() -> RocketLaunchTableViewCell {
        guard let cell: RocketLaunchTableViewCell = tableView.dequeueReusableCell(withIdentifier: RocketLaunchTableViewCell.kReuseIdentifier) as? RocketLaunchTableViewCell else {
            fatalError("Not registered for tableView")
        }
        
        cell.mainImageView.kf.setImage(with: URL(string: viewModel.launch.imageUrl))
        cell.rocketLabel.text = viewModel.launch.rocket
        cell.missionLabel.text = viewModel.launch.mission
        cell.providerLabel.text = viewModel.launch.provider
        cell.padLabel.text = viewModel.launch.pad
        cell.windowStartLabel.text = viewModel.launch.windowStart
        cell.statusLabel.text = viewModel.launch.status
        cell.isUserInteractionEnabled = false
        
        return cell
    }
    
    func getProviderCell() -> ProviderTableViewCell{
        guard let cell: ProviderTableViewCell = tableView.dequeueReusableCell(withIdentifier: ProviderTableViewCell.kReuseIdentifier) as? ProviderTableViewCell else {
            fatalError("Not registered for tableView")
        }
        
        cell.logoImageView.kf.setImage(with: URL(string: viewModel.provider!.logoUrl))
        cell.titleLabel.text = viewModel.provider!.name
        cell.descriptionLabel.text = viewModel.provider!.description
        cell.isUserInteractionEnabled = false
        
        return cell
    }
    
    func getMissionCell() -> UITableViewCell{
        return UITableViewCell()
    }
    
    func getPadCell() -> UITableViewCell{
        return UITableViewCell()
    }
 
}

extension RocketLaunchInformationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
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
        switch viewModel.sections[indexPath.section] {
        case .launch:
            return getLaunchCell()
        case .provider:
            return getProviderCell()
        case .mission:
            return getMissionCell()
        case .pad:
            return getPadCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.sections[indexPath.section] {
        case .launch:
            return 180
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
