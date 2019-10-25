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
            (success, feed, error) in

            if error != nil {
                self.router?.showCannotReadTattooFeed()
                return
            }

            guard let tattooFeed = feed else {
                self.router?.showCannotReadTattooFeed()
                return
            }

            self.viewController?.populate(tattooFeed)
        })
    }
    
    func retrieveTattoo(with identifier: String) {
        interactor?.retrieveTattoo(with: identifier, completion: {
            (success, detail, error) in

            if error != nil {
                self.router?.showCannotReadTattooDetail()
                return
            }

            guard let tattoo = detail else {
                self.router?.showCannotReadTattooDetail()
                return
            }

            DispatchQueue.global(qos: .userInitiated).async {
              DispatchQueue.main.async {
                  [unowned self] in
                  
                  self.router?.showDetail(with: tattoo)
              }
            }
        })
    }
}
