//
//  DayNightView.swift
//  Demo
//
//  Created by Raúl Pérez on 24/10/2019.
//  Copyright © 2019 Raúl Pérez. All rights reserved.
//

import UIKit

class DayNightView: NibDesignable {

    static let dayNighToggleName = "dayNighToggle"
    
    @IBOutlet weak var toggleButton: UISegmentedControl!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func didChangedValue(_ sender: Any) {
        Theme.saveCurrentTheme(rawValue: toggleButton.selectedSegmentIndex)
        NotificationCenter.default.post(name: .dayNighToggle, object: nil, userInfo: nil)
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        toggleButton.selectedSegmentIndex = Theme.current.rawValue
    }
    
    func updateTheme() {
        toggleButton.selectedSegmentIndex = Theme.current.rawValue
    }
}
