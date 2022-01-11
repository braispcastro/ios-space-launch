//
//  EventsViewController.swift
//  Events
//
//  Created by Brais Castro on 24/12/21.
//

import UIKit
import Lottie
import GoogleMobileAds
import AppTrackingTransparency

final class EventViewController: BaseViewController {

    var presenter: EventPresenterProtocol!
    private var viewModel: Event.ViewModel!
    private var eventList: [EventListProtocol] = []

    // MARK: - Component Declaration
    
    private var rocketAnimationView: AnimationView!
    private var tableView: UITableView!
    private var refreshControl: UIRefreshControl!

    private enum ViewTraits {
        static let margins = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: -15)
        static let lottieMargins = UIEdgeInsets(top: 96, left: 96, bottom: -96, right: -96)
    }
    
    public enum AccessibilityIds {
        static let view: String = "events-view"
        static let rocketAnimationView: String = "rocket-animation-view"
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
        tableView.isHidden = true
        tableView.separatorStyle = .none
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: EventTableViewCell.kReuseIdentifier)
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
        presenter.getEventsToShow()
    }

    // MARK: Private Methods
    
    private func getEventCell(_ event: Event.EventViewModel) -> EventTableViewCell {
        guard let cell: EventTableViewCell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.kReuseIdentifier) as? EventTableViewCell else {
            fatalError("Not registered for tableView")
        }
        
        cell.mainImageView.kf.setImage(with: URL(string: event.imageUrl ?? ""), placeholder: UIImage(named: "Rocket"))
        cell.nameLabel.text = event.name
        cell.locationLabel.text = event.location
        cell.typeLabel.text = event.type
        cell.descriptionLabel.text = event.description
        cell.dateLabel.text = event.date
        cell.isUserInteractionEnabled = false
        
        return cell
    }
    
    private func getAdCell(_ ad: Event.GoogleNativeAd) -> GoogleAdTableViewCell {
        guard let cell: GoogleAdTableViewCell = tableView.dequeueReusableCell(withIdentifier: GoogleAdTableViewCell.kReuseIdentifier) as? GoogleAdTableViewCell else {
            fatalError("Not registered for tableView")
        }
        
        cell.googleAdView.rootViewController = self
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                cell.googleAdView.load(GADRequest())
            })
        } else {
            cell.googleAdView.load(GADRequest())
        }
        
        return cell
    }

}

// MARK: - EventsViewControllerProtocol

extension EventViewController: EventViewControllerProtocol {
    
    func show(viewModel: Event.ViewModel) {
        self.viewModel = viewModel
        self.title = viewModel.title
    }
    
    func showEvents(eventList: [EventListProtocol]) {
        self.eventList = eventList
        rocketAnimationView.stop()
        rocketAnimationView.isHidden = true
        tableView.isHidden = false
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
 
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension EventViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        let item = eventList[indexPath.section]
        if let launch = item as? Event.EventViewModel {
            return getEventCell(launch)
        } else if let ad = item as? Event.GoogleNativeAd {
            return getAdCell(ad)
        } else {
            fatalError("Only two types allowed")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
