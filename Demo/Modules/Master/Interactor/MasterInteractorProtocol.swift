//
//  MasterInteractorProtocol.swift
//  Demo
//
//  Created by Raúl Pérez on 24/10/2019.
//  Copyright © 2019 Raúl Pérez. All rights reserved.
//

import Foundation

protocol MasterInteractorProtocol {
    
    func retrieveTattooFeed(page: UInt?, completion: TattooFeedHandler?)
    func retrieveTattoo(with identifier: String, completion: TattooHandler?)
    func downloadImage(with url: String, completion: ImageHandler?)
}
