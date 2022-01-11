//
//  HeaderView.swift
//  RocketLaunch
//
//  Created by Brais Castro on 25/12/21.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {
    
    static let kReuseIdentifier: String = "header-view"

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        self.tintColor = UIColor.systemGray6
        self.textLabel?.textColor = UIColor.darkGray
    }
}
