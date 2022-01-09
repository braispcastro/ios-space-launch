//
//  RocketLaunchViewController.swift
//  RocketLaunch
//
//  Created by Brais Castro on 24/12/21.
//

import UIKit
import Kingfisher
import Lottie
import GoogleMobileAds

final class RocketLaunchViewController: BaseViewController {

    var presenter: RocketLaunchPresenterProtocol!    
    private var viewModel: RocketLaunch.ViewModel!
    private var launchList: [LaunchListProtocol] = []

    // MARK: - Component Declaration
    
    private var rocketAnimationView: AnimationView!
    private var tableView: UITableView!
    private var refreshControl: UIRefreshControl!
    
    private enum ViewTraits {
        static let margins = UIEdgeInsets(top: 15, left: 15, bottom: -15, right: -15)
        static let lottieMargins = UIEdgeInsets(top: 96, left: 96, bottom: -96, right: -96)
    }
    
    public enum AccessibilityIds {
        static let view: String = "rocket-launch-view"
        static let rocketAnimationView: String = "rocket-animation-view"
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
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        tableView.separatorStyle = .none
        tableView.register(RocketLaunchTableViewCell.self, forCellReuseIdentifier: RocketLaunchTableViewCell.kReuseIdentifier)
        tableView.register(GoogleAdTableViewCell.self, forCellReuseIdentifier: GoogleAdTableViewCell.kReuseIdentifier)
        view.addSubview(tableView)
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        let rocketAnimation = Animation.named("rgb-rocket-loading")
        rocketAnimationView = AnimationView(animation: rocketAnimation)
        rocketAnimationView.translatesAutoresizingMaskIntoConstraints = false
        rocketAnimationView.backgroundColor = UIColor.clear
        rocketAnimationView.clipsToBounds = true
        rocketAnimationView.contentMode = .scaleAspectFit
        rocketAnimationView.loopMode = .loop
        rocketAnimationView.play(completion: nil)
        view.addSubview(rocketAnimationView)
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func setupConstraints() {
        NSLayoutConstraint.activate([
            rocketAnimationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rocketAnimationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rocketAnimationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ViewTraits.lottieMargins.left),
            rocketAnimationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ViewTraits.lottieMargins.right),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    override func setupAccessibilityIdentifiers() {
        view.accessibilityIdentifier = AccessibilityIds.view
        rocketAnimationView.accessibilityIdentifier = AccessibilityIds.rocketAnimationView
        tableView.accessibilityIdentifier = AccessibilityIds.tableView
    }

    // MARK: - Actions
    
    @objc func refresh(_ sender: AnyObject) {
        presenter.getLaunchesToShow()
    }

    // MARK: Private Methods
    
    private func getLaunchCell(_ launch: RocketLaunch.LaunchViewModel) -> RocketLaunchTableViewCell {
        guard let cell: RocketLaunchTableViewCell = tableView.dequeueReusableCell(withIdentifier: RocketLaunchTableViewCell.kReuseIdentifier) as? RocketLaunchTableViewCell else {
            fatalError("Not registered for tableView")
        }
        
        cell.mainImageView.kf.setImage(with: URL(string: launch.imageUrl ?? ""), placeholder: UIImage(named: "Rocket"))
        cell.rocketLabel.text = launch.rocket
        cell.missionLabel.text = launch.mission
        cell.providerLabel.text = launch.provider
        cell.padLabel.text = launch.pad
        cell.windowStartLabel.text = launch.windowStart
        cell.statusLabel.text = launch.status
        cell.statusLabel.textColor = UIColor.fromLaunchStatus(launchStatus: launch.statusType)
        cell.setupTimer(stringDate: launch.windowStart)
        
        return cell
    }
    
    private func getAdCell(_ ad: RocketLaunch.GoogleNativeAd) -> GoogleAdTableViewCell {
        guard let cell: GoogleAdTableViewCell = tableView.dequeueReusableCell(withIdentifier: GoogleAdTableViewCell.kReuseIdentifier) as? GoogleAdTableViewCell else {
            fatalError("Not registered for tableView")
        }
        
        cell.googleAdView.rootViewController = self
        cell.googleAdView.load(GADRequest())
        
        return cell
    }
}

// MARK: - RocketLaunchViewControllerProtocol

extension RocketLaunchViewController: RocketLaunchViewControllerProtocol {
    
    func show(viewModel: RocketLaunch.ViewModel) {
        self.viewModel = viewModel
        self.title = viewModel.title
    }
    
    func showLaunches(launchList: [LaunchListProtocol]) {
        self.launchList = launchList
        rocketAnimationView.stop()
        rocketAnimationView.isHidden = true
        tableView.isHidden = false
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
 
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension RocketLaunchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return launchList.count
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
        let item = launchList[indexPath.section]
        if let launch = item as? RocketLaunch.LaunchViewModel {
            return getLaunchCell(launch)
        } else if let ad = item as? RocketLaunch.GoogleNativeAd {
            return getAdCell(ad)
        } else {
            fatalError("Only two types allowed")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = launchList[indexPath.section]
        if item.isAd {
            return UITableView.automaticDimension
        } else {
            return 180
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = launchList[indexPath.section]
        if let launch = item as? RocketLaunch.LaunchViewModel {
            presenter.launchTapped(launch: launch.rawData)
        }
    }
    
}
