//
//  MasterPresenter.swift
//  Demo
//
//  Created by Raúl Pérez on 20/02/2019.
//  Copyright © 2019 Raúl Pérez. All rights reserved.
//

import Foundation

class MasterPresenter {

    // Module Properties
    internal var interactor: MasterInteractorProtocol?
    internal var viewController: MasterViewControllerProtocol?
    internal var router: MasterRouterProtocol?

    init() {
    }

    deinit {
    }
}

extension MasterPresenter : MasterPresenterProtocol {
    
    func retrieveTattooFeed() {
        retrieveTattooFeed(page: 0)
    }
    
    func retrieveTattooFeed(page: UInt? = 0) {
        interactor?.retrieveTattooFeed(page: page, completion: {
            (result) in
            
            switch result {
            case .success(let tattooFeed):
                self.viewController?.populate(tattooFeed)
            case .failure(_):
                self.router?.showCannotReadTattooFeed()
            }
        })
    }
    
    func retrieveTattoo(with identifier: String) {
        interactor?.retrieveTattoo(with: identifier, completion: {
            (result) in
            
            switch result {
            case .success(let tattoo):
                DispatchQueue.global(qos: .userInitiated).async {
                  DispatchQueue.main.async {
                      [unowned self] in
                      
                      self.router?.showDetail(with: tattoo)
                  }
                }
            case .failure(_):
                self.router?.showCannotReadTattooDetail()
            }
        })
    }
    
    func downloadTattooImage(with url: String, completion: ImageHandler?) {
        interactor?.downloadImage(with: url, completion: completion)
    }
}
