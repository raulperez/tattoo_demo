//
//  ConnectionManager.swift
//  Demo
//
//  Created by Raúl Pérez Gómez on 24/10/2019.
//  Copyright © 2019 Raúl Pérez. All rights reserved.
//

import UIKit

class ConnectionManager: NSObject {

    static func retrieveTattooFeed(page: UInt? = 0, completion: @escaping (Bool, TattooFeed?, Error?) -> Swift.Void) {
        guard let page = page else {
            print("Page invalid")

            completion(false, nil, CustomErrors.pageInvalid)
            return
        }

        guard let url = URL(string: "https://backend-api.tattoodo.com/api/v2/search/posts?page=\(String(page))") else {
            print("URL is empty or invalid")

            completion(false, nil, CustomErrors.invalidOrEmptyURL)
            return
        }
        

        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"

        session.dataTask(with: request as URLRequest) {
            data, response, error in

            guard let data = data else {
                print("Error downloading data")

                completion(false, nil, CustomErrors.cannotReceiveData)
                return
            }
            
            do {
                let tattooFeed = try JSONDecoder().decode(TattooFeed.self, from: data)

                print("Response data:", tattooFeed)

                completion(true, tattooFeed, nil)
            } catch let error {
                print("Error decoding data: ", error)
                completion(false, nil, CustomErrors.cannotReceiveData)
            }
        }.resume()
    }
    
    static func retrieveTattoo(with identifier: String, completion: @escaping (Bool, Tattoo?, Error?) -> Swift.Void) {

        guard let url = URL(string: "https://backend-api.tattoodo.com/api/v2/posts/\(identifier)") else {
            print("URL is empty or invalid")

            completion(false, nil, CustomErrors.invalidOrEmptyURL)
            return
        }
        

        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"

        session.dataTask(with: request as URLRequest) {
            data, response, error in

            guard let data = data else {
                print("Error downloading data")

                completion(false, nil, CustomErrors.cannotReceiveData)
                return
            }
            
            do {
                let tattooData = try JSONDecoder().decode(TattooDetail.self, from: data)

                print("Response data:", tattooData)

                guard let tattoo = tattooData.data else {
                    print("Error parsing data")

                    completion(false, nil, CustomErrors.cannotReceiveData)
                    return
                }

                completion(true, tattoo, nil)
            } catch let error {
                print("Error decoding data: ", error)
                completion(false, nil, CustomErrors.cannotReceiveData)
            }
        }.resume()
    }
    
    static func downloadImage(with url: String, completion: @escaping (UIImage?, Error?) -> ()) {
        guard let url = URL(string: url) else {
            print("URL is empty or invalid")

            completion(nil, CustomErrors.invalidOrEmptyURL)
            return
        }
        
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in

            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            completion(UIImage(data: data), nil)
        }.resume()
    }
}
