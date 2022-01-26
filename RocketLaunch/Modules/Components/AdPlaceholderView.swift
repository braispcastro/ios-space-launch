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
    //private var placeholderLabel: UILabel!
    
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
        adBannerView.delegate = self
        adBannerView.frame = CGRect(x: ViewTraits.adBannerX,
                                   y: ViewTraits.adBannerY,
                                   width: ViewTraits.adBannerWidth,
                                   height: ViewTraits.adBannerHeight)
        adBannerView.backgroundColor = UIColor.init(named: "AccentColor")
        adBannerView.loadAd()
        adBannerView.startAutoRefresh()
        self.addSubview(adBannerView)
        
        //placeholderLabel = UILabel()
        //placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        //placeholderLabel.text = "Advertisement"
        //placeholderLabel.textColor = UIColor.white
        //self.addSubview(placeholderLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            //placeholderLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            //placeholderLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            adBannerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            adBannerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            adBannerView.topAnchor.constraint(equalTo: self.topAnchor),
            adBannerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

// MARK: - MAAdViewAdDelegate
extension AdPlaceholderView: MAAdViewAdDelegate {
    
    func didLoad(_ ad: MAAd) {
        print("didLoad")
    }
    
    func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) {
        print(error)
    }
    
    func didClick(_ ad: MAAd) {
        //print("didClick")
    }
    
    func didFail(toDisplay ad: MAAd, withError error: MAError) {
        print(error)
    }
    
    func didExpand(_ ad: MAAd) {
        //print("didExpand")
    }
    
    func didCollapse(_ ad: MAAd) {
        //print("didCollapse")
    }
    
    func didDisplay(_ ad: MAAd) {
        // DEPRECATED
    }
    
    func didHide(_ ad: MAAd) {
        // DEPRECATED
    }
    
}
