//
//  InformationViewController.swift
//  Information
//
//  Created by Brais Castro on 26/12/21.
//

import UIKit
import MapKit

final class InformationViewController: BaseViewController, AdBannerViewController {

    var presenter: InformationPresenterProtocol!
    private var viewModel: Information.ViewModel!

    // MARK: - Component Declaration
    
    internal var adBannerPlaceholder: UIView?
    
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
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(RocketLaunchTableViewCell.self, forCellReuseIdentifier: RocketLaunchTableViewCell.kReuseIdentifier)
        tableView.register(ProviderTableViewCell.self, forCellReuseIdentifier: ProviderTableViewCell.kReuseIdentifier)
        tableView.register(MissionTableViewCell.self, forCellReuseIdentifier: MissionTableViewCell.kReuseIdentifier)
        tableView.register(PadTableViewCell.self, forCellReuseIdentifier: PadTableViewCell.kReuseIdentifier)
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        	
        adBannerPlaceholder = UIView()
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
    
    @objc private func goToURL(sender: UIButton) {
        if sender.accessibilityIdentifier == "info-button", let infoUri = viewModel.provider!.infoUrl, let infoUrl = URL(string: infoUri) {
            UIApplication.shared.open(infoUrl)
        }
        if sender.accessibilityIdentifier == "wiki-button", let wikiUri = viewModel.provider!.wikiUrl, let wikiUrl = URL(string: wikiUri) {
            UIApplication.shared.open(wikiUrl)
        }
    }
    
    // MARK: Private Methods

}

// MARK: - InformationViewControllerProtocol

extension InformationViewController: InformationViewControllerProtocol {
    
    func show(viewModel: Information.ViewModel) {
        self.viewModel = viewModel
        self.title = viewModel.title
    }
    
    func getLaunchCell() -> RocketLaunchTableViewCell {
        guard let cell: RocketLaunchTableViewCell = tableView.dequeueReusableCell(withIdentifier: RocketLaunchTableViewCell.kReuseIdentifier) as? RocketLaunchTableViewCell else {
            fatalError("Not registered for tableView")
        }
        
        cell.mainImageView.kf.setImage(with: URL(string: viewModel.launch.imageUrl ?? ""), placeholder: UIImage(named: "Rocket"))
        cell.rocketLabel.text = viewModel.launch.rocket
        cell.missionLabel.text = viewModel.launch.mission
        cell.providerLabel.text = viewModel.launch.provider
        cell.padLabel.text = viewModel.launch.pad
        cell.windowStartLabel.text = viewModel.launch.windowStart
        cell.statusLabel.text = viewModel.launch.status
        cell.statusLabel.textColor = UIColor.fromLaunchStatus(launchStatus: viewModel.launch.statusType)
        cell.setupTimer(stringDate: viewModel.launch.windowStart)
        cell.isUserInteractionEnabled = false
        
        return cell
    }
    
    func getProviderCell() -> ProviderTableViewCell {
        guard let cell: ProviderTableViewCell = tableView.dequeueReusableCell(withIdentifier: ProviderTableViewCell.kReuseIdentifier) as? ProviderTableViewCell else {
            fatalError("Not registered for tableView")
        }
        
        if let image = viewModel.provider!.logoUrl {
            cell.logoImageView.kf.setImage(with: URL(string: image))
        } else {
            cell.logoImageView.isHidden = true
        }
        
        cell.selectionStyle = .none
        cell.descriptionLabel.text = viewModel.provider!.description
        cell.infoButton.addTarget(self, action: #selector(goToURL(sender:)), for: .touchUpInside)
        cell.wikiButton.addTarget(self, action: #selector(goToURL(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func getMissionCell() -> UITableViewCell {
        guard let cell: MissionTableViewCell = tableView.dequeueReusableCell(withIdentifier: MissionTableViewCell.kReuseIdentifier) as? MissionTableViewCell else {
            fatalError("Not registered for tableView")
        }
        
        if let image = viewModel.mission!.logoUrl {
            cell.logoImageView.kf.setImage(with: URL(string: image))
        } else {
            cell.logoImageView.isHidden = true
        }
        
        cell.titleLabel.text = viewModel.mission!.name
        cell.typeLabel.text = viewModel.mission!.type
        cell.descriptionLabel.text = viewModel.mission!.description
        cell.isUserInteractionEnabled = false
        
        return cell
    }
    
    func getPadCell() -> UITableViewCell {
        guard let cell: PadTableViewCell = tableView.dequeueReusableCell(withIdentifier: PadTableViewCell.kReuseIdentifier) as? PadTableViewCell else {
            fatalError("Not registered for tableView")
        }
        
        if let lat = viewModel.pad!.latitude, let lon = viewModel.pad!.longitude {
            let center = CLLocationCoordinate2D(latitude: CLLocationDegrees(Double(lat)!), longitude: CLLocationDegrees(Double(lon)!))
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = center
            
            cell.mapView.addAnnotation(annotation)
            
            cell.mapView.setRegion(region, animated: true)
        } else {
            cell.mapView.isHidden = true
        }
        
        cell.titleLabel.text = viewModel.pad!.name
        cell.locationLabel.text = viewModel.pad!.location
        
        return cell
    }
 
}

extension InformationViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        
        let tappedCell = tableView.cellForRow(at: indexPath)!
        if tappedCell.isKind(of: PadTableViewCell.self) {
            presenter.padCellTapped(pad: viewModel.pad!)
        }
    }
    
}
