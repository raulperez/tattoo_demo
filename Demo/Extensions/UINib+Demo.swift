//
//  UINib+Demo.swift
//  Demo
//
//  Created by Raúl Pérez on 24/10/2019.
//  Copyright © 2019 Raúl Pérez. All rights reserved.
//

import UIKit

extension UINib {
    
    static func instance(withNibName name: String, bundle: Bundle? = Bundle.main, owner: Any? = nil, position: Int = 0) -> UIView? {
        return UINib(nibName: name, bundle: bundle).instantiate(withOwner: owner, options: nil)[position] as? UIView
    }
}
