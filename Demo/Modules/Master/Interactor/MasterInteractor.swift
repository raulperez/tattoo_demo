//
//  MasterInteractor.swift
//  Demo
//
//  Created by Raúl Pérez on 24/10/2019.
//  Copyright © 2019 Raúl Pérez. All rights reserved.
//

import Foundation

class MasterInteractor {

    internal var presenter: MasterPresenterProtocol?

    init() {
    }
    
    deinit {
    }
}

extension MasterInteractor : MasterInteractorProtocol {
    
    func retrieveTattooFeed(page: UInt? = 0, completion: TattooFeedHandler? = nil) {
        ConnectionManager.retrieveTattooFeed(page: page, completion: completion)
    }
    
    func retrieveTattoo(with identifier: String, completion: TattooHandler? = nil) {
        ConnectionManager.retrieveTattoo(with: identifier, completion: completion)
    }
    
    func downloadImage(with url: String, completion: ImageHandler? = nil) {
        ConnectionManager.downloadImage(with: url, completion: completion)
    }
}
