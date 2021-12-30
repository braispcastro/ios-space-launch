//
//  UIColor+Status.swift
//  RocketLaunch
//
//  Created by Brais Castro on 30/12/21.
//

import UIKit.UIColor
import UIKit

public extension UIColor {
    
    internal class func fromLaunchStatus(launchStatus: Space.Launch.Result.Status.StatusType) -> UIColor {
        switch launchStatus {
        case .success, .go:
            return UIColor.systemGreen
        case .inFlight:
            return UIColor.systemBlue
        case .failure, .partialFailure:
            return UIColor.systemRed
        case .hold, .toBeConfirmed, .toBeDetermined:
            return UIColor.systemOrange
        case .unknown:
            return UIColor.black
        }
    }
}
