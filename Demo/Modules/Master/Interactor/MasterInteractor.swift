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
    
    func retrieveTattooFeed(page: UInt? = 0, completion: @escaping (Bool, TattooFeed?, Error?) -> Swift.Void) {
        ConnectionManager.retrieveTattooFeed(page: page) {
            (success, feed, error) in
            
            if error != nil {
                completion(false, nil, error)
                return
            }
            
            completion(true, feed, nil)
        }
    }
    
    func retrieveTattoo(with identifier: String, completion: @escaping (Bool, Tattoo?, Error?) -> Swift.Void) {
        ConnectionManager.retrieveTattoo(with: identifier, completion: {
            (success, detail, error) in
            
            if error != nil {
                completion(false, nil, error)
                return
            }
            
            completion(true, detail, nil)
        })
    }
}
