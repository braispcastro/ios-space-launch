//
//  RocketLaunchTableViewCell.swift
//  RocketLaunch
//
//  Created by Brais Castro on 25/12/21.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    static let kReuseIdentifier: String = "event-table-view-cell"
    
    // MARK: - Component Declaration
    
    internal var vStackView: UIStackView!
    internal var mainImageView: UIImageView!
    internal var nameLabel: UILabel!
    internal var locationLabel: UILabel!
    internal var typeLabel: UILabel!
    internal var descriptionLabel: UILabel!
    internal var dateLabel: UILabel!
    
    private enum ViewTraits {
        static let margins = UIEdgeInsets(top: 8, left: 8, bottom: -8, right: -8)
        static let labelMargins = UIEdgeInsets(top: 2, left: 2, bottom: -2, right: -2)
    }
    
    public enum AccessibilityIds {
        static let cell: String = "cell"
        static let vStackView: String = "vertical-stack-view"
        static let mainImageView: String = "main-image-view"
        static let nameLabel: String = "name-label"
        static let locationLabel: String = "location-label"
        static let typeLabel: String = "type-label"
        static let descriptionLabel: String = "description-label"
        static let dateLabel: String = "date-label"
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
        mainImageView = UIImageView()
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        mainImageView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.clipsToBounds = true
        self.addSubview(mainImageView)
        
        vStackView = UIStackView()
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.axis = .vertical
        self.addSubview(vStackView)
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        nameLabel.textAlignment = .center
        vStackView.addArrangedSubview(nameLabel)
        
        locationLabel = UILabel()
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        locationLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        locationLabel.textAlignment = .center
        vStackView.addArrangedSubview(locationLabel)
        
        typeLabel = UILabel()
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        typeLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        typeLabel.textAlignment = .center
        vStackView.addArrangedSubview(typeLabel)
        
        descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 3
        vStackView.addArrangedSubview(descriptionLabel)
        
        dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        dateLabel.textAlignment = .center
        vStackView.addArrangedSubview(dateLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: self.topAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainImageView.heightAnchor.constraint(equalToConstant: 150),
            
            vStackView.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: ViewTraits.margins.top),
            vStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ViewTraits.margins.bottom),
            vStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ViewTraits.margins.left),
            vStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ViewTraits.margins.right),
            
            nameLabel.bottomAnchor.constraint(equalTo: locationLabel.topAnchor, constant: ViewTraits.margins.bottom),
            locationLabel.bottomAnchor.constraint(equalTo: typeLabel.topAnchor, constant: ViewTraits.labelMargins.bottom),
            typeLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: ViewTraits.margins.bottom),
            descriptionLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: ViewTraits.margins.bottom)
        ])
    }
    
    func setupAccessibilityIdentifiers() {
        self.accessibilityIdentifier = AccessibilityIds.cell
        vStackView.accessibilityIdentifier = AccessibilityIds.vStackView
        mainImageView.accessibilityIdentifier = AccessibilityIds.mainImageView
        nameLabel.accessibilityIdentifier = AccessibilityIds.nameLabel
        locationLabel.accessibilityIdentifier = AccessibilityIds.locationLabel
        typeLabel.accessibilityIdentifier = AccessibilityIds.typeLabel
        descriptionLabel.accessibilityIdentifier = AccessibilityIds.descriptionLabel
        dateLabel.accessibilityIdentifier = AccessibilityIds.dateLabel
    }

}
