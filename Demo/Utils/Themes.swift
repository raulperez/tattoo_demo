//
//  Themes.swift
//  Demo
//
//  Created by Raúl Pérez on 24/10/2019.
//  Copyright © 2019 Raúl Pérez. All rights reserved.
//

import UIKit

enum Theme: Int {

    case day, night
    
    var primaryColor: UIColor {
        switch self {
        case .day:
            return UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        case .night:
            return UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        }
    }

    var secondaryColor: UIColor {
        switch self {
        case .day:
            return UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        case .night:
            return UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .day:
            return UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        case .night:
            return UIColor(red: 150.0/255.0, green: 150.0/255.0, blue: 150.0/255.0, alpha: 1.0)
        }
    }
    
    var barStyle: UIBarStyle {
        switch self {
        case .day :
            return .default
        case .night:
            return .black
        }
    }
    
    private enum UserDefaultsKey {
        static let currentTheme = "currentTheme"
    }
    
    static var current: Theme {
        let savedTheme = UserDefaults.standard.integer(forKey: UserDefaultsKey.currentTheme)
        return Theme(rawValue: savedTheme) ?? .day
    }
    
    static func saveCurrentTheme(rawValue: Int) {
        UserDefaults.standard.set(rawValue, forKey: UserDefaultsKey.currentTheme)
        UserDefaults.standard.synchronize()
    }
}
