//
//  ProviderTableViewCell.swift
//  RocketLaunch
//
//  Created by Brais Castro on 26/12/21.
//

import UIKit

class ProviderTableViewCell: UITableViewCell {

    static let kReuseIdentifier: String = "provider-table-view-cell"
    
    var infoUrl: String?
    var wikiUrl: String?
    
    // MARK: - Component Declaration
    
    internal var vStackView: UIStackView!
    internal var logoImageView: UIImageView!
    internal var titleLabel: UILabel!
    internal var descriptionLabel: UILabel!
    internal var hStackView: UIStackView!
    internal var infoView: UIView!
    internal var infoButton: UIButton!
    internal var wikiView: UIView!
    internal var wikiButton: UIButton!
    
    private enum ViewTraits {
        static let margins = UIEdgeInsets(top: 12, left: 12, bottom: -12, right: -12)
        static let labelMargins = UIEdgeInsets(top: 8, left: 8, bottom: -8, right: -8)
    }
    
    public enum AccessibilityIds {
        static let cell: String = "cell"
        static let vStackView: String = "vertical-stack-view"
        static let logoImageView: String = "logo-image-view"
        static let titleLabel: String = "title-label"
        static let descriptionLabel: String = "description-label"
        static let hStackView: String = "horizontal-stack-view"
        static let infoView: String = "info-view"
        static let infoButton: String = "info-button"
        static let wikiView: String = "wiki-view"
        static let wikiButton: String = "wiki-button"
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
        contentView.addSubview(vStackView)
        
        logoImageView = UIImageView()
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.clipsToBounds = true
        vStackView.addArrangedSubview(logoImageView)
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textAlignment = .center
        vStackView.addArrangedSubview(titleLabel)
        
        descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textAlignment = .justified
        descriptionLabel.numberOfLines = 0
        vStackView.addArrangedSubview(descriptionLabel)
        
        hStackView = UIStackView()
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.axis = .horizontal
        hStackView.distribution = .fillEqually
        hStackView.contentMode = .center
        hStackView.spacing = 30
        vStackView.addArrangedSubview(hStackView)
        
        infoView = UIView()
        infoView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.addArrangedSubview(infoView)
        
        infoButton = UIButton()
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        infoButton.contentVerticalAlignment = .fill
        infoButton.contentHorizontalAlignment = .fill
        infoButton.setImage(UIImage.init(systemName: "info.circle"), for: .normal)
        infoButton.contentMode = .scaleAspectFill
        infoButton.tintColor = UIColor.init(named: "AccentColor")
        infoView.addSubview(infoButton)
        
        wikiView = UIView()
        wikiView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.addArrangedSubview(wikiView)
        
        wikiButton = UIButton()
        wikiButton.translatesAutoresizingMaskIntoConstraints = false
        wikiButton.contentVerticalAlignment = .fill
        wikiButton.contentHorizontalAlignment = .fill
        wikiButton.setImage(UIImage.init(systemName: "w.circle"), for: .normal)
        wikiButton.contentMode = .scaleAspectFill
        wikiButton.tintColor = UIColor.init(named: "AccentColor")
        wikiView.addSubview(wikiButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewTraits.margins.top),
            vStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: ViewTraits.margins.bottom),
            vStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ViewTraits.margins.left),
            vStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: ViewTraits.margins.right),
            
            logoImageView.heightAnchor.constraint(equalToConstant: 120),
            
            logoImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: ViewTraits.margins.bottom),
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: ViewTraits.labelMargins.bottom),
            descriptionLabel.bottomAnchor.constraint(equalTo: hStackView.topAnchor, constant: ViewTraits.margins.bottom),
            
            hStackView.heightAnchor.constraint(equalToConstant: 50),
            
            infoButton.centerXAnchor.constraint(equalTo: infoView.centerXAnchor),
            infoButton.centerYAnchor.constraint(equalTo: infoView.centerYAnchor),
            infoButton.heightAnchor.constraint(equalTo: infoView.heightAnchor),
            infoButton.heightAnchor.constraint(equalTo: infoButton.widthAnchor),
            wikiButton.centerXAnchor.constraint(equalTo: wikiView.centerXAnchor),
            wikiButton.centerYAnchor.constraint(equalTo: wikiView.centerYAnchor),
            wikiButton.heightAnchor.constraint(equalTo: wikiView.heightAnchor),
            wikiButton.heightAnchor.constraint(equalTo: wikiButton.widthAnchor)
        ])
    }
    
    private func setupAccessibilityIdentifiers() {
        self.accessibilityIdentifier = AccessibilityIds.cell
        vStackView.accessibilityIdentifier = AccessibilityIds.vStackView
        logoImageView.accessibilityIdentifier = AccessibilityIds.logoImageView
        titleLabel.accessibilityIdentifier = AccessibilityIds.titleLabel
        descriptionLabel.accessibilityIdentifier = AccessibilityIds.descriptionLabel
        hStackView.accessibilityIdentifier = AccessibilityIds.hStackView
        infoButton.accessibilityIdentifier = AccessibilityIds.infoButton
        wikiButton.accessibilityIdentifier = AccessibilityIds.wikiButton
    }

}
