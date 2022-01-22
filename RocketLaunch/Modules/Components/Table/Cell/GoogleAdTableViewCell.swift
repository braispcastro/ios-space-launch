//
//  GoogleAdTableViewCell.swift
//  RocketLaunch
//
//  Created by Brais Castro on 9/1/22.
//

import UIKit
import GoogleMobileAds

class GoogleAdTableViewCell: UITableViewCell {

    static let kReuseIdentifier: String = "google-ad-table-view-cell"
    
    // MARK: - Component Declaration
    
    internal var googleAdView: GADBannerView!
    
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
        let adSize = GADAdSizeFromCGSize(CGSize(width: 320, height: 266))
        googleAdView = GADBannerView(adSize: adSize)
        #if DEBUG
        googleAdView.adUnitID = Constants.kAdBannerTest
        #else
        googleAdView.adUnitID = FirebaseRCService.shared.googleAdBannerId!
        #endif
        googleAdView.delegate = self
        googleAdView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(googleAdView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            googleAdView.topAnchor.constraint(equalTo: self.topAnchor),
            googleAdView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            googleAdView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            googleAdView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func setupAccessibilityIdentifiers() {
        self.accessibilityIdentifier = AccessibilityIds.cell
        googleAdView.accessibilityIdentifier = AccessibilityIds.googleAdView
    }

}

extension GoogleAdTableViewCell: GADBannerViewDelegate {
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("bannerViewDidReceiveAd")
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
        print("bannerViewDidRecordImpression")
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("bannerViewWillPresentScreen")
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("bannerViewWillDIsmissScreen")
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("bannerViewDidDismissScreen")
    }
    
}
