//
//  AdPlaceholderView.swift
//  RocketLaunch
//
//  Created by Castro, Brais on 2/2/22.
//

import UIKit

class AdPlaceholderView: UIView {
    
    private var placeholderLabel: UILabel!
    
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

        placeholderLabel = UILabel()
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.text = "Ad not available"
        placeholderLabel.textColor = UIColor.white
        self.addSubview(placeholderLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            placeholderLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            placeholderLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
