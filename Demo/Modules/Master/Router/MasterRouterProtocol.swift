//
//  MasterRouterProtocol.swift
//  Demo
//
//  Created by Raúl Pérez on 24/10/2019.
//  Copyright © 2019 Raúl Pérez. All rights reserved.
//

import Foundation
import UIKit

protocol MasterRouterProtocol {
    
    func showCannotReadTattooFeed()
    func showCannotShowTattooFeed()
    func showCannotReadTattooDetail()
    func showCannotShowTattooDetail()
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func showDetail(with tattoo: Tattoo)
}
