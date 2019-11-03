//
//  NibDesignable.swift
//  Demo
//
//  Created by Raúl Pérez on 24/10/2019.
//  Copyright © 2019 Raúl Pérez. All rights reserved.
//

import UIKit

@IBDesignable

public class NibDesignable: UIView {
    
    var innerView : Any? = nil
    var filesOwner : Any? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupNib()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.setupNib()
    }
    
    private func setupNib() {
        innerView = UINib.instance(withNibName: nibName(), bundle: Bundle.init(for: type(of: self)), owner: self)
        filesOwner = self
        
        if let innerView = innerView as? UIView {
            self.addSubview(innerView)            
        }
    }
    
    public func nibName() -> String {
        return type(of: self).description().components(separatedBy: ".").last!
    }
}
