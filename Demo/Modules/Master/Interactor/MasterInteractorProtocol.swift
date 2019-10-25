//
//  MasterInteractorProtocol.swift
//  Demo
//
//  Created by Raúl Pérez on 24/10/2019.
//  Copyright © 2019 Raúl Pérez. All rights reserved.
//

import Foundation

protocol MasterInteractorProtocol {
    
    func retrieveTattooFeed(page: UInt?, completion: @escaping (Bool, TattooFeed?, Error?) -> Swift.Void)
    func retrieveTattoo(with identifier: String, completion: @escaping (Bool, Tattoo?, Error?) -> Swift.Void)
}
