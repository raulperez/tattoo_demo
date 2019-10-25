//
//  MasterRouter.swift
//  Demo
//
//  Created by Raúl Pérez on 24/10/2019.
//  Copyright © 2019 Raúl Pérez. All rights reserved.
//

import Foundation
import UIKit

class MasterRouter {
    
    internal var presenter: MasterPresenterProtocol?
    internal var viewController: MasterViewControllerProtocol?

    // Class Properties
    private let showDetailSegue = "showDetailSegue"

    init() {
    }
    
    deinit {
    }
    
    private func showAlert(title: String, message: String, button: String) {
        guard let viewController = viewController as? UIViewController else { return }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: button, style: .default)
        alertController.addAction(action)
        
        viewController.present(alertController, animated: true, completion:nil)
    }
}

extension MasterRouter : MasterRouterProtocol {
    
    func showCannotReadTattooFeed() {
        showAlert(title: "Warning", message: "An error ocurred while trying to read the list of tattoos...", button: "DIMISS")
    }
    
    func showCannotShowTattooFeed() {
        showAlert(title: "Warning", message: "An error ocurred while trying to show the list of tattoos...", button: "DIMISS")
    }

    func showCannotReadTattooDetail() {
        showAlert(title: "Warning", message: "An error ocurred while trying to read tattoo's details...", button: "DIMISS")
    }
    
    func showCannotShowTattooDetail() {
        showAlert(title: "Warning", message: "An error ocurred while trying to show tattoo's details...", button: "DIMISS")
    }
    
    func showDetail(with tattoo: Tattoo) {
        guard let viewController = viewController as? UIViewController else { return }

        viewController.performSegue(withIdentifier: showDetailSegue, sender: tattoo)
    }

    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == showDetailSegue {
            guard let tattoo = sender as? Tattoo else { return }
            guard let destinationViewController = segue.destination as? DetailViewController else { return }
            destinationViewController.tattoo = tattoo
        }
    }
}
