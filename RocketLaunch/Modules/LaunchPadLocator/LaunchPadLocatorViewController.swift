//
//  LaunchPadLocatorViewController.swift
//  RocketLaunch
//
//  Created by Brais Castro on 4/1/22.
//

import UIKit
import MapKit

final class LaunchPadLocatorViewController: BaseViewController {

    var presenter: LaunchPadLocatorPresenterProtocol!
    private var viewModel: LaunchPadLocator.ViewModel!

    // MARK: - Component Declaration
    
    private var mapView: MKMapView!

    private enum ViewTraits {
        static let margins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    public enum AccessibilityIds {
        static let view: String = "launch-pad-locator-view"
        static let mapView: String = "launch-pad-locator-map-view"
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
        mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.mapType = .hybridFlyover
        view.addSubview(mapView)
        
        adBannerPlaceholder.removeFromSuperview()
    }

    override func setupConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    override func setupAccessibilityIdentifiers() {
        view.accessibilityIdentifier = AccessibilityIds.view
        mapView.accessibilityIdentifier = AccessibilityIds.mapView
    }

    // MARK: - Actions

    // MARK: Private Methods

}

// MARK: - LaunchPadLocatorViewControllerProtocol

extension LaunchPadLocatorViewController: LaunchPadLocatorViewControllerProtocol {
    
    func show(viewModel: LaunchPadLocator.ViewModel) {
        let center = CLLocationCoordinate2D(latitude: CLLocationDegrees(Double(viewModel.latitude)!),
                                            longitude: CLLocationDegrees(Double(viewModel.longitude)!))
        
        let region = MKCoordinateRegion(center: center,
                                        span: MKCoordinateSpan(latitudeDelta: 0.6, longitudeDelta: 0.6))
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        
        mapView.addAnnotation(annotation)
        mapView.setRegion(region, animated: true)
    }
 
}
