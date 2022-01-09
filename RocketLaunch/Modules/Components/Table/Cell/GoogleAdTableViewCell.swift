//
//  GoogleAdTableViewCell.swift
//  RocketLaunch
//
//  Created by Castro, Brais on 9/1/22.
//

import UIKit
import GoogleMobileAds

class GoogleAdTableViewCell: UITableViewCell {

    static let kReuseIdentifier: String = "google-ad-table-view-cell"
    
    // MARK: - Component Declaration
    
    internal var googleAdView: GADNativeAdView!
    
    private enum ViewTraits {
        static let margins = UIEdgeInsets(top: 8, left: 8, bottom: -8, right: -8)
    }
    
    public enum AccessibilityIds {
        static let cell: String = "cell"
        static let googleAdView: String = "google-ad-view"
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
        googleAdView = GADNativeAdView()
        googleAdView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(googleAdView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            googleAdView.topAnchor.constraint(equalTo: self.topAnchor, constant: ViewTraits.margins.top),
            googleAdView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ViewTraits.margins.bottom),
            googleAdView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ViewTraits.margins.left),
            googleAdView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ViewTraits.margins.right)
        ])
    }
    
    private func setupAccessibilityIdentifiers() {
        self.accessibilityIdentifier = AccessibilityIds.cell
        googleAdView.accessibilityIdentifier = AccessibilityIds.googleAdView
    }

}
