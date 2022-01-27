//
//  AdPlaceholderView.swift
//  RocketLaunch
//
//  Created by Brais Castro on 22/1/22.
//

import UIKit
import AppLovinSDK

class AdPlaceholderView: UIView {
    
    static let shared = AdPlaceholderView()
    
    private var adBannerView: MAAdView!
    
    public enum ViewTraits {
        static let adBannerHeight: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? CGFloat(90) : CGFloat(50)
        static let adBannerWidth: CGFloat = UIScreen.main.bounds.width
        static let adBannerX = UIScreen.main.bounds.minX
        static let adBannerY = UIScreen.main.bounds.minY
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods
    
    private func setupView() {
        self.backgroundColor = UIColor.init(named: "AccentColor")
        
        adBannerView = MAAdView(adUnitIdentifier: FirebaseRCService.shared.appLovinAdBannerUnitId)
        adBannerView.translatesAutoresizingMaskIntoConstraints = false
        adBannerView.frame = CGRect(x: ViewTraits.adBannerX,
                                   y: ViewTraits.adBannerY,
                                   width: ViewTraits.adBannerWidth,
                                   height: ViewTraits.adBannerHeight)
        adBannerView.backgroundColor = UIColor.init(named: "AccentColor")
        adBannerView.loadAd()
        adBannerView.startAutoRefresh()
        self.addSubview(adBannerView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            adBannerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            adBannerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            adBannerView.topAnchor.constraint(equalTo: self.topAnchor),
            adBannerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
