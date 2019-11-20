//
//  DemoTests.swift
//  DemoTests
//
//  Created by Raúl Pérez Gómez on 25/10/2019.
//  Copyright © 2019 Raúl Pérez. All rights reserved.
//

import XCTest
@testable import Demo

class DemoTests: XCTestCase {

    var masterInteractor : MasterInteractor? = nil
    var masterViewController : MasterViewController? = nil
    
    override func setUp() {
        masterInteractor = MasterInteractor()
        masterViewController = (UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? UINavigationController)?.topViewController as? MasterViewController
    }

    override func tearDown() {
        masterInteractor = nil
        masterViewController = nil
    }

    func test_ConnectionManager_retrieveTattoo_Tattoo() {
        // Given
        let tattooId = "11234"
        let promise = expectation(description: "Tattoo downloaded and parsed")
        var resultTattoo : Tattoo? = nil
        
        // When
        ConnectionManager.retrieveTattoo(with: tattooId) {
            (result) in

            switch result {
            case .success(let tattoo):
                resultTattoo = tattoo
                promise.fulfill()
            case .failure(let error):
                var errorMessage = "Didn't result with success even is parsed tattoo data from fake response."
                let description = error.localizedDescription
                
                if description != "" {
                    errorMessage.append("\nError: \(description)")
                }

                XCTFail(errorMessage)
            }
        }
        
        wait(for: [promise], timeout: 10)
        
        // Then
        XCTAssertNotNil(resultTattoo, "Didn't parsed tattoo from fake response")
    }

    func test_ConnectionManager_retrieveTattooFeed_TattooFeed() {
        // Given
        let promise = expectation(description: "TattooFeed downloaded and parsed")
        var resultTattooFeed : TattooFeed? = nil
        
        // When
        ConnectionManager.retrieveTattooFeed() {
            (result) in

            switch result {
            case .success(let tattooFeed):
                resultTattooFeed = tattooFeed
                promise.fulfill()
            case .failure(let error):
                var errorMessage = "Didn't result with success even is parsed tattoo feed from fake response."
                let description = error.localizedDescription
                
                if description != "" {
                    errorMessage.append("\nError: \(description)")
                }

                XCTFail(errorMessage)
            }
        }
        
        wait(for: [promise], timeout: 10)
        
        // Then
        XCTAssertNotNil(resultTattooFeed, "Didn't parsed tattoo feed from fake response")
    }

    func test_ConnectionManager_downloadImage_Image() {
        // Given
        let promise = expectation(description: "Image downloaded")
        let url = "https://tattoodo-mobile-app.imgix.net/images/posts/20180615_bMBHqFz8yZzdNEB.png"
        var resultImage : UIImage? = nil
        
        // When
        ConnectionManager.downloadImage(with: url, completion: {
            (result, cached) in
            
            switch result {
            case .success(let image):
                resultImage = image
                promise.fulfill()
            case .failure(let error):
                var errorMessage = "Didn't downloaded the image."
                let description = error.localizedDescription
                
                if description != "" {
                    errorMessage.append("\nError: \(description)")
                }

                XCTFail(errorMessage)
            }

        })
        
        wait(for: [promise], timeout: 10)
        
        // Then
        XCTAssertNotNil(resultImage, "Didn't downloaded the image")
    }

    func test_MasterInteractor_retrieveTattooFeed_TattooFeed() {
        // Given
        let promise = expectation(description: "TattooFeed downloaded and parsed")
        var resultTattooFeed : TattooFeed? = nil
        
        // When
        masterInteractor?.retrieveTattooFeed() {
            (result) in

            switch result {
            case .success(let tattooFeed):
                resultTattooFeed = tattooFeed
                promise.fulfill()
            case .failure(let error):
                var errorMessage = "Didn't result with success even is parsed tattoo feed from fake response."
                let description = error.localizedDescription
                
                if description != "" {
                    errorMessage.append("\nError: \(description)")
                }

                XCTFail(errorMessage)
            }
        }
        
        wait(for: [promise], timeout: 10)
        
        // Then
        XCTAssertNotNil(resultTattooFeed, "Didn't parsed tattoo feed from fake response")
    }
    
    func test_MasterInteractor_retrieveTattoo_Tattoo() {
        // Given
        let tattooId = "11234"
        let promise = expectation(description: "Tattoo downloaded and parsed")
        var resultTattoo : Tattoo? = nil
        
        // When
        masterInteractor?.retrieveTattoo(with: tattooId) {
            (result) in

            switch result {
            case .success(let tattoo):
                resultTattoo = tattoo
                promise.fulfill()
            case .failure(let error):
                var errorMessage = "Didn't result with success even is parsed tattoo data from fake response."
                let description = error.localizedDescription
                
                if description != "" {
                    errorMessage.append("\nError: \(description)")
                }

                XCTFail(errorMessage)
            }
        }
        
        wait(for: [promise], timeout: 10)
        
        // Then
        XCTAssertNotNil(resultTattoo, "Didn't parsed tattoo from fake response")
    }

    func test_MasterViewController_retrieveTattooFeed_TattooFeed() {
        // Given
        guard let masterViewController = masterViewController else {
            XCTFail("MasterViewController is nil")
            return
        }

        guard let presenter = masterViewController.presenter as? MasterPresenter else {
            XCTFail("MasterViewController's presenter is nil")
            return
        }

        guard let interactor = presenter.interactor else {
            XCTFail("MasterViewController's presenter's interactor is nil")
            return
        }
        
        guard let viewController = presenter.viewController else {
            XCTFail("MasterViewController's presenter's viewController is nil")
            return
        }
        
        let promise = expectation(description: "TattooFeed downloaded and parsed")

        interactor.retrieveTattooFeed(page: 0, completion: {
            (result) in

            switch result {
            case .success(let tattooFeed):
                viewController.populate(tattooFeed)
                promise.fulfill()
            case .failure(let error):
                var errorMessage = "Didn't result with success even is parsed tattoo feed from fake response."
                let description = error.localizedDescription
                
                if description != "" {
                    errorMessage.append("\nError: \(description)")
                }

                XCTFail(errorMessage)
            }
        })

        XCTAssertEqual(masterViewController.tattoos.count, 0, "Tattoos list should be empty before task runs")
        
        wait(for: [promise], timeout: 10)
        
        // Then
        XCTAssertGreaterThanOrEqual(masterViewController.tattoos.count, 1, "Tattoos list shouldn't be empty after task runs")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
