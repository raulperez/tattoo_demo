//
//  DetailInteractor.swift
//  Demo
//
//  Created by Raúl Pérez on 24/10/2019.
//  Copyright © 2019 Raúl Pérez. All rights reserved.
//

import Foundation

class DetailInteractor {

    var presenter: DetailPresenterProtocol?

    init() {
    }
    
    deinit {
    }
}

extension DetailInteractor : DetailInteractorProtocol {

    func downloadImage(with url: String, completion: ImageHandler? = nil) {
        ConnectionManager.downloadImage(with: url, completion: completion)
    }
}
