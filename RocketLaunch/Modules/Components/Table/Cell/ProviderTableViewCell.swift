//
//  ProviderTableViewCell.swift
//  RocketLaunch
//
//  Created by Brais Castro on 26/12/21.
//

import UIKit

class ProviderTableViewCell: UITableViewCell {

    static let kReuseIdentifier: String = "provider-table-view-cell"
    
    // MARK: - Component Declaration
    
    internal var vStackView: UIStackView!
    internal var logoImageView: UIImageView!
    internal var titleLabel: UILabel!
    internal var descriptionLabel: UILabel!
    
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
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: ViewTraits.margins.top),
            vStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ViewTraits.margins.bottom),
            vStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ViewTraits.margins.left),
            vStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ViewTraits.margins.right),
            
            logoImageView.heightAnchor.constraint(equalToConstant: 120),
            
            logoImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: ViewTraits.margins.bottom),
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: ViewTraits.labelMargins.bottom)
        ])
    }
    
    private func setupAccessibilityIdentifiers() {
        self.accessibilityIdentifier = AccessibilityIds.cell
        vStackView.accessibilityIdentifier = AccessibilityIds.vStackView
        logoImageView.accessibilityIdentifier = AccessibilityIds.logoImageView
        titleLabel.accessibilityIdentifier = AccessibilityIds.titleLabel
        descriptionLabel.accessibilityIdentifier = AccessibilityIds.descriptionLabel
    }

}
