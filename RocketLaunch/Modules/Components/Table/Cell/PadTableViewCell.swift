//
//  PadTableViewCell.swift
//  RocketLaunch
//
//  Created by Castro, Brais on 26/12/21.
//

import UIKit
import MapKit

class PadTableViewCell: UITableViewCell {

    static let kReuseIdentifier: String = "pad-table-view-cell"
    
    // MARK: - Component Declaration
    
    internal var vStackView: UIStackView!
    internal var titleLabel: UILabel!
    internal var locationLabel: UILabel!
    internal var mapView: MKMapView!
    
    private enum ViewTraits {
        static let margins = UIEdgeInsets(top: 12, left: 12, bottom: -12, right: -12)
        static let labelMargins = UIEdgeInsets(top: 8, left: 8, bottom: -8, right: -8)
    }
    
    public enum AccessibilityIds {
        static let cell: String = "cell"
        static let vStackView: String = "vertical-stack-view"
        static let titleLabel: String = "title-label"
        static let locationLabel: String = "location-label"
        static let mapView: String = "map-view"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupComponents()
        setupConstraints()
        setupAccessibilityIdentifiers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Setup
    
    private func setupComponents() {
        vStackView = UIStackView()
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.axis = .vertical
        self.addSubview(vStackView)
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textAlignment = .center
        vStackView.addArrangedSubview(titleLabel)
        
        locationLabel = UILabel()
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        locationLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        locationLabel.textAlignment = .center
        vStackView.addArrangedSubview(locationLabel)
        
        mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.isUserInteractionEnabled = false
        vStackView.addArrangedSubview(mapView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: ViewTraits.margins.top),
            vStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ViewTraits.margins.bottom),
            vStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ViewTraits.margins.left),
            vStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ViewTraits.margins.right),
            
            mapView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.bottomAnchor.constraint(equalTo: locationLabel.topAnchor, constant: ViewTraits.labelMargins.bottom),
            locationLabel.bottomAnchor.constraint(equalTo: mapView.topAnchor, constant: ViewTraits.margins.bottom)
        ])
    }
    
    private func setupAccessibilityIdentifiers() {
        self.accessibilityIdentifier = AccessibilityIds.cell
        vStackView.accessibilityIdentifier = AccessibilityIds.vStackView
        titleLabel.accessibilityIdentifier = AccessibilityIds.titleLabel
        locationLabel.accessibilityIdentifier = AccessibilityIds.locationLabel
        mapView.accessibilityIdentifier = AccessibilityIds.mapView
    }

}
