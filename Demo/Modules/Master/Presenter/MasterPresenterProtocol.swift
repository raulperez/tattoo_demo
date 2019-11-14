//
//  MasterPresenterProtocol.swift
//  Demo
//
//  Created by Raúl Pérez on 20/02/2019.
//  Copyright © 2019 Raúl Pérez. All rights reserved.
//

import Foundation

protocol MasterPresenterProtocol {
    
    func retrieveTattooFeed()
    func retrieveTattooFeed(page: UInt?)
    func retrieveTattoo(with identifier: String)
    func downloadTattooImage(with url: String, completion: ImageHandler?)
}
