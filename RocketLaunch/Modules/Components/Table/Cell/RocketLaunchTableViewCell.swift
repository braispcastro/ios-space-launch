//
//  RocketLaunchTableViewCell.swift
//  RocketLaunch
//
//  Created by Brais Castro on 25/12/21.
//

import UIKit

class RocketLaunchTableViewCell: UITableViewCell {

    static let kReuseIdentifier: String = "rocket-launch-table-view-cell"
    
    private var timer: Timer!
    
    // MARK: - Component Declaration
    
    internal var hStackView: UIStackView!
    internal var mainImageView: UIImageView!
    internal var vStackView: UIStackView!
    internal var rocketLabel: UILabel!
    internal var missionLabel: UILabel!
    internal var providerLabel: UILabel!
    internal var padLabel: UILabel!
    internal var windowStartLabel: UILabel!
    internal var statusLabel: UILabel!
    
    private enum ViewTraits {
        static let margins = UIEdgeInsets(top: 8, left: 8, bottom: -8, right: -8)
        static let labelMargins = UIEdgeInsets(top: 2, left: 2, bottom: -2, right: -2)
    }
    
    public enum AccessibilityIds {
        static let cell: String = "cell"
        static let hStackView: String = "horizontal-stacl-view"
        static let mainImageView: String = "main-image-view"
        static let vStackView: String = "vertical-stack-view"
        static let rocketLabel: String = "rocket-label"
        static let missionLabel: String = "mission-label"
        static let providerLabel: String = "provider-label"
        static let padLabel: String = "pad-label"
        static let windowStartLabel: String = "window-start-label"
        static let statusLabel: String = "status-label"
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
        hStackView = UIStackView()
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.axis = .horizontal
        self.addSubview(hStackView)
        
        mainImageView = UIImageView()
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        mainImageView.backgroundColor = UIColor.init(named: "AccentColor")
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.clipsToBounds = true
        hStackView.addArrangedSubview(mainImageView)
        
        vStackView = UIStackView()
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.axis = .vertical
        hStackView.addArrangedSubview(vStackView)
        
        rocketLabel = UILabel()
        rocketLabel.translatesAutoresizingMaskIntoConstraints = false
        rocketLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        rocketLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        rocketLabel.textAlignment = .center
        vStackView.addArrangedSubview(rocketLabel)
        
        missionLabel = UILabel()
        missionLabel.translatesAutoresizingMaskIntoConstraints = false
        missionLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        missionLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        missionLabel.textAlignment = .center
        vStackView.addArrangedSubview(missionLabel)
        
        providerLabel = UILabel()
        providerLabel.translatesAutoresizingMaskIntoConstraints = false
        providerLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        providerLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        providerLabel.textAlignment = .center
        vStackView.addArrangedSubview(providerLabel)
        
        padLabel = UILabel()
        padLabel.translatesAutoresizingMaskIntoConstraints = false
        padLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        padLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        padLabel.textAlignment = .center
        vStackView.addArrangedSubview(padLabel)
        
        windowStartLabel = UILabel()
        windowStartLabel.translatesAutoresizingMaskIntoConstraints = false
        windowStartLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        windowStartLabel.textAlignment = .center
        vStackView.addArrangedSubview(windowStartLabel)
        
        statusLabel = UILabel()
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        statusLabel.textColor = UIColor.init(named: "GoForLaunchColor")
        statusLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        statusLabel.textAlignment = .center
        vStackView.addArrangedSubview(statusLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            hStackView.topAnchor.constraint(equalTo: self.topAnchor),
            hStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            hStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            hStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            hStackView.rightAnchor.constraint(equalTo: vStackView.rightAnchor, constant: ViewTraits.margins.left),
            
            mainImageView.topAnchor.constraint(equalTo: hStackView.topAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: hStackView.bottomAnchor),
            mainImageView.widthAnchor.constraint(equalToConstant: 100),
            
            vStackView.topAnchor.constraint(equalTo: hStackView.topAnchor, constant: ViewTraits.margins.top),
            vStackView.bottomAnchor.constraint(equalTo: hStackView.bottomAnchor, constant: ViewTraits.margins.bottom),
            vStackView.leftAnchor.constraint(equalTo: mainImageView.rightAnchor, constant: ViewTraits.margins.left),
            
            rocketLabel.bottomAnchor.constraint(equalTo: missionLabel.topAnchor, constant: ViewTraits.labelMargins.bottom),
            missionLabel.bottomAnchor.constraint(equalTo: providerLabel.topAnchor, constant: ViewTraits.margins.bottom),
            providerLabel.bottomAnchor.constraint(equalTo: padLabel.topAnchor, constant: ViewTraits.labelMargins.bottom),
            padLabel.bottomAnchor.constraint(equalTo: windowStartLabel.topAnchor, constant: ViewTraits.margins.bottom),
            windowStartLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor, constant: ViewTraits.margins.bottom)
        ])
    }
    
    private func setupAccessibilityIdentifiers() {
        self.accessibilityIdentifier = AccessibilityIds.cell
        hStackView.accessibilityIdentifier = AccessibilityIds.hStackView
        mainImageView.accessibilityIdentifier = AccessibilityIds.mainImageView
        vStackView.accessibilityIdentifier = AccessibilityIds.vStackView
        rocketLabel.accessibilityIdentifier = AccessibilityIds.rocketLabel
        missionLabel.accessibilityIdentifier = AccessibilityIds.missionLabel
        providerLabel.accessibilityIdentifier = AccessibilityIds.providerLabel
        padLabel.accessibilityIdentifier = AccessibilityIds.padLabel
        windowStartLabel.accessibilityIdentifier = AccessibilityIds.windowStartLabel
        statusLabel.accessibilityIdentifier = AccessibilityIds.statusLabel
    }
    
    // MARK: - Public Methods
    
    func setupTimer() {
        if let tMinusZero = windowStartLabel.text {
            if let tMinusZeroDate = ISO8601DateFormatter().date(from: tMinusZero) {
                let interval = tMinusZeroDate.timeIntervalSinceReferenceDate - Date().timeIntervalSinceReferenceDate
                if interval > 0 {
                    let ti = NSInteger(interval)
                    let seconds = ti % 60
                    let minutes = (ti / 60) % 60
                    let hours = (ti / 3600)
                    if hours < 25 {
                        windowStartLabel.text = "T - \(hours)H : \(minutes)M : \(seconds)S"
                    }
                }
            }
        }
    }

}
