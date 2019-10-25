//
//  DetailRouter.swift
//  Demo
//
//  Created by Raúl Pérez on 24/10/2019.
//  Copyright © 2019 Raúl Pérez. All rights reserved.
//

import Foundation
import UIKit

class DetailRouter {

    var presenter: DetailPresenterProtocol?
    var viewController: DetailViewControllerProtocol?

    init() {
    }
    
    deinit {
    }
}

extension DetailRouter : DetailRouterProtocol {

    func dismiss() {
        guard let viewController = viewController as? UIViewController else { return }
        
        viewController.dismiss(animated: true)
    }
}
