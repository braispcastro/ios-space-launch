//
//  RocketLaunchViewController.swift
//  RocketLaunch
//
//  Created by Brais Castro on 24/12/21.
//

import UIKit
import FirebaseMessaging
import Kingfisher
import Lottie

final class RocketLaunchViewController: BaseViewController, AdBannerViewController {

    var presenter: RocketLaunchPresenterProtocol!    
    private var viewModel: RocketLaunch.ViewModel!
    private var launchList: [RocketLaunch.LaunchViewModel] = []

    // MARK: - Component Declaration
    
    internal var adBannerPlaceholder: UIView?
    
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
        self.tabBarItem.selectedImage = UIImage(systemName: "paperplane.fill")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ViewLife Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.prepareView()
        configureApp()
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
        
        adBannerPlaceholder = UIView()
        adBannerPlaceholder!.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(adBannerPlaceholder!)
    }

    override func setupConstraints() {
        NSLayoutConstraint.activate([
            rocketAnimationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rocketAnimationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rocketAnimationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ViewTraits.lottieMargins.left),
            rocketAnimationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ViewTraits.lottieMargins.right),
            
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
        rocketAnimationView.accessibilityIdentifier = AccessibilityIds.rocketAnimationView
        tableView.accessibilityIdentifier = AccessibilityIds.tableView
    }

    // MARK: - Actions
    
    @objc func refresh(_ sender: AnyObject) {
        presenter.getLaunchesToShow()
    }

    // MARK: Private Methods
    
    private func configureApp() {
        self.tabBarController?.tabBar.isUserInteractionEnabled = false
        // Firebase configuration
        FirebaseRCService.shared.fetch() {
            super.requestPermissionForAds {
                DispatchQueue.main.async {
                    AdBannerManager.shared.rootViewController = self
                    self.presenter.getLaunchesToShow()
                    self.requestPushNotificationsPermission()
                    self.tabBarController?.tabBar.isUserInteractionEnabled = true
                }
            }
        }
    }
    
    private func requestPushNotificationsPermission() {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { granted, error in
            guard granted else { return }
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                guard settings.authorizationStatus == .authorized else { return }
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                    #if DEBUG
                    Messaging.messaging().unsubscribe(fromTopic: "production")
                    Messaging.messaging().subscribe(toTopic: "development")
                    #else
                    Messaging.messaging().unsubscribe(fromTopic: "development")
                    Messaging.messaging().subscribe(toTopic: "production")
                    #endif
                }
            }
        }
    }
}

// MARK: - RocketLaunchViewControllerProtocol

extension RocketLaunchViewController: RocketLaunchViewControllerProtocol {
    
    func show(viewModel: RocketLaunch.ViewModel) {
        self.viewModel = viewModel
        self.title = viewModel.title
    }
    
    func showLaunches(launchList: [RocketLaunch.LaunchViewModel]) {
        self.launchList = launchList
        rocketAnimationView.stop()
        rocketAnimationView.isHidden = true
        tableView.isHidden = false
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    func listUpdateRejected() {
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
        guard let cell: RocketLaunchTableViewCell = tableView.dequeueReusableCell(withIdentifier: RocketLaunchTableViewCell.kReuseIdentifier) as? RocketLaunchTableViewCell else {
            fatalError("Not registered for tableView")
        }
        
        cell.mainImageView.kf.setImage(with: URL(string: launchList[indexPath.section].imageUrl ?? ""), placeholder: UIImage(named: "Rocket"))
        cell.rocketLabel.text = launchList[indexPath.section].rocket
        cell.missionLabel.text = launchList[indexPath.section].mission
        cell.providerLabel.text = launchList[indexPath.section].provider
        cell.padLabel.text = launchList[indexPath.section].pad
        cell.windowStartLabel.text = launchList[indexPath.section].windowStart
        cell.statusLabel.text = launchList[indexPath.section].status
        cell.statusLabel.textColor = UIColor.fromLaunchStatus(launchStatus: launchList[indexPath.section].statusType)
        cell.setupTimer(stringDate: launchList[indexPath.section].windowStart)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.launchTapped(launch: launchList[indexPath.section].rawData)
    }
    
}
