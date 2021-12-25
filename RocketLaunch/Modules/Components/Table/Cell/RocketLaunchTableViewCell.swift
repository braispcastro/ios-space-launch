//
//  RocketLaunchTableViewCell.swift
//  RocketLaunch
//
//  Created by Castro, Brais on 25/12/21.
//

import UIKit

class RocketLaunchTableViewCell: UITableViewCell {

    static let kReuseIdentifier: String = "rocket-launch-table-view-cell"
    
    // MARK: - Component Declaration
    
    internal var hStackView: UIStackView!
    internal var mainImageView: UIImageView!
    internal var vStackView: UIStackView!
    internal var titleLabel: UILabel!
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
        static let titleLabel: String = "title-label"
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
    
    func setupComponents() {
        hStackView = UIStackView()
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.axis = .horizontal
        self.addSubview(hStackView)
        
        mainImageView = UIImageView()
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.clipsToBounds = true
        hStackView.addArrangedSubview(mainImageView)
        
        vStackView = UIStackView()
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.axis = .vertical
        hStackView.addArrangedSubview(vStackView)
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textAlignment = .center
        vStackView.addArrangedSubview(titleLabel)
        
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
        statusLabel.backgroundColor = UIColor.init(named: "GoForLaunchColor")
        statusLabel.textColor = UIColor.white
        statusLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        statusLabel.textAlignment = .center
        vStackView.addArrangedSubview(statusLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            hStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: ViewTraits.margins.top),
            hStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ViewTraits.margins.bottom),
            hStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ViewTraits.margins.left),
            hStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ViewTraits.margins.right),
            
            mainImageView.topAnchor.constraint(equalTo: hStackView.topAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: hStackView.bottomAnchor),
            mainImageView.widthAnchor.constraint(equalToConstant: 100),
            
            vStackView.leftAnchor.constraint(equalTo: mainImageView.rightAnchor, constant: ViewTraits.margins.left),
            
            titleLabel.bottomAnchor.constraint(equalTo: providerLabel.topAnchor, constant: ViewTraits.labelMargins.bottom),
            providerLabel.bottomAnchor.constraint(equalTo: padLabel.topAnchor, constant: ViewTraits.labelMargins.bottom),
            padLabel.bottomAnchor.constraint(equalTo: windowStartLabel.topAnchor, constant: ViewTraits.labelMargins.bottom),
            windowStartLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor, constant: ViewTraits.labelMargins.bottom),
            statusLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func setupAccessibilityIdentifiers() {
        self.accessibilityIdentifier = AccessibilityIds.cell
        hStackView.accessibilityIdentifier = AccessibilityIds.hStackView
        mainImageView.accessibilityIdentifier = AccessibilityIds.mainImageView
        vStackView.accessibilityIdentifier = AccessibilityIds.vStackView
        titleLabel.accessibilityIdentifier = AccessibilityIds.titleLabel
        providerLabel.accessibilityIdentifier = AccessibilityIds.providerLabel
        padLabel.accessibilityIdentifier = AccessibilityIds.padLabel
        windowStartLabel.accessibilityIdentifier = AccessibilityIds.windowStartLabel
        statusLabel.accessibilityIdentifier = AccessibilityIds.statusLabel
    }

}
