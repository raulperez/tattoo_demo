//
//  DetailPresenter.swift
//  Demo
//
//  Created by Raúl Pérez on 24/10/2019.
//  Copyright © 2019 Raúl Pérez. All rights reserved.
//

import Foundation
import UIKit

class DetailPresenter {

    // Module Properties
    var interactor: DetailInteractorProtocol?
    var viewController: DetailViewControllerProtocol?
    var router: DetailRouterProtocol?

    init() {
    }

    deinit {
    }
}

extension DetailPresenter : DetailPresenterProtocol {

    func downloadTattooImage(with url: String) {
        interactor?.downloadImage(with: url, completion: {
            (result, cached) in
            
            switch result {
            case .success(let image):
                self.viewController?.populateTattooImage(with: image)
            case .failure(_): break
            }
        })
    }

    func downloadArtistImage(with url: String) {
        interactor?.downloadImage(with: url, completion: {
            (result, cached) in
            
            switch result {
            case .success(let image):
                self.viewController?.populateArtistImage(with: image)
            case .failure(_): break
            }
        })
    }

}
