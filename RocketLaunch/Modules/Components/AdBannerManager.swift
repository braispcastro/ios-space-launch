//
//  AdsManager.swift
//  RocketLaunch
//
//  Created by Brais Castro on 2/2/22.
//

import UIKit
import GoogleMobileAds

protocol AdBannerViewController: UIViewController {
    var adBannerPlaceholder: AdPlaceholderView? { get }
    func addBannerToAdsPlaceholder(_ banner: UIView)
}

extension AdBannerViewController {
    func addBannerToAdsPlaceholder(_ banner: UIView) {
        adBannerPlaceholder?.addSubview(banner)
    }
}

final class AdBannerManager: NSObject {

    static let shared = AdBannerManager()

    var loadedSimpleBannerAd = false

    private var bannerView: GADBannerView?
    var rootViewController: UIViewController? {
        didSet {
            setupSimpleBannerAdsIfPossible()
        }
    }

    public enum ViewTraits {
        static let adBannerWidth: CGFloat = UIScreen.main.bounds.width
        static let adBannerHeight: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? CGFloat(90) : CGFloat(50)
    }

    public override init() {
        super.init()

        configureSimpleBanner()
    }

    private func configureSimpleBanner() {
        bannerView = GADBannerView(adSize: GADAdSizeFullWidthPortraitWithHeight(ViewTraits.adBannerHeight))
        bannerView?.delegate = self
    }

    private func setupSimpleBannerAdsIfPossible() {
        assert(self.bannerView != nil, "Simple banner has not been configured (call Ads.configure() before any usage)!")
        guard let adUnitId = FirebaseRCService.shared.googleAdBannerUnitId else { return }

        if let root = rootViewController as? AdBannerViewController {
            if let banner = self.bannerView {
                banner.rootViewController = root
                if !loadedSimpleBannerAd {
                    banner.adUnitID = adUnitId
                    banner.load(GADRequest())
                } else {
                    root.addBannerToAdsPlaceholder(banner)
                }
            }
        }
    }

}

// MARK: - GADBannerViewDelegate
extension AdBannerManager: GADBannerViewDelegate {

    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        loadedSimpleBannerAd = true
        if let root = rootViewController as? AdBannerViewController {
            root.addBannerToAdsPlaceholder(bannerView)
        }
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

}
