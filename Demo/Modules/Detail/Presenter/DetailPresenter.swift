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
        ConnectionManager.downloadImage(with: url) {
            [unowned self] (image, error) in

            guard let image = image else { return }
            self.viewController?.populateTattooImage(with: image)
        }
    }

    func downloadArtistImage(with url: String) {
        ConnectionManager.downloadImage(with: url) {
            (image, error) in
            
            guard let image = image else { return }
            self.viewController?.populateArtistImage(with: image)
        }
    }

}
