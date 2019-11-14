//
//  ConnectionManager.swift
//  Demo
//
//  Created by Raúl Pérez Gómez on 24/10/2019.
//  Copyright © 2019 Raúl Pérez. All rights reserved.
//

import UIKit

enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case failure(Error)
}

typealias TattooFeedHandler = (Result<TattooFeed, CustomError>) -> Swift.Void
typealias TattooHandler = (Result<Tattoo, CustomError>) -> Swift.Void
typealias ImageHandler = (Result<UIImage, CustomError>, Bool?) -> Swift.Void

class ConnectionManager: NSObject {

    static func retrieveTattooFeed(page: UInt? = 0, completion: TattooFeedHandler? = nil) {
        guard let page = page else {
            print("Page invalid")

            guard let completion = completion else { return }
            completion(.failure(CustomError.pageInvalid))
            return
        }

        guard let url = URL(string: "https://backend-api.tattoodo.com/api/v2/search/posts?page=\(String(page))") else {
            print("URL is empty or invalid")

            guard let completion = completion else { return }
            completion(.failure(CustomError.invalidOrEmptyURL))
            return
        }
        

        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"

        session.dataTask(with: request as URLRequest) {
            data, response, error in

            guard let data = data else {
                print("Error downloading data")

                guard let completion = completion else { return }
                completion(.failure(CustomError.cannotReceiveData))
                return
            }
            
            do {
                let tattooFeed = try JSONDecoder().decode(TattooFeed.self, from: data)

                //print("Response data:", tattooFeed)

                guard let completion = completion else { return }
                completion(.success(tattooFeed))
            } catch let error {
                print("Error decoding data: ", error)

                guard let completion = completion else { return }
                completion(.failure(CustomError.cannotReceiveData))
            }
        }.resume()
    }
    
    static func retrieveTattoo(with identifier: String, completion: TattooHandler? = nil) {

        guard let url = URL(string: "https://backend-api.tattoodo.com/api/v2/posts/\(identifier)") else {
            print("URL is empty or invalid")

            guard let completion = completion else { return }
            completion(.failure(CustomError.invalidOrEmptyURL))
            return
        }

        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"

        session.dataTask(with: request as URLRequest) {
            data, response, error in

            guard let data = data else {
                print("Error downloading data")

                guard let completion = completion else { return }
                completion(.failure(CustomError.cannotReceiveData))
                return
            }
            
            do {
                let tattooData = try JSONDecoder().decode(TattooDetail.self, from: data)

                //print("Response data:", tattooData)

                guard let tattoo = tattooData.data else {
                    print("Error parsing data")

                    guard let completion = completion else { return }
                    completion(.failure(CustomError.cannotReceiveData))
                    return
                }

                guard let completion = completion else { return }
                completion(.success(tattoo))
            } catch let error {
                print("Error decoding data: ", error)

                guard let completion = completion else { return }
                completion(.failure(CustomError.cannotReceiveData))
            }
        }.resume()
    }
    
    static func downloadImage(with url: String, completion: ImageHandler? = nil) {
        guard let url = URL(string: url) else {
            print("URL is empty or invalid")

            guard let completion = completion else { return }
            completion(.failure(CustomError.invalidOrEmptyURL), nil)
            return
        }
        
        let request = URLRequest.init(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 60)
        
        if let data = URLCache.shared.cachedResponse(for: request)?.data {
            guard let image = UIImage(data: data) else {
                
                guard let completion = completion else { return }
                completion(.failure(CustomError.cannotReceiveData), nil)
                return
            }
            
            guard let completion = completion else { return }
            completion(.success(image), true)
        } else {
            URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                
                guard let data = data, error == nil else {

                    guard let completion = completion else { return }
                    completion(.failure(CustomError.cannotReceiveData), nil)
                    return
                }
                
                guard let image = UIImage(data: data) else {
                    
                    guard let completion = completion else { return }
                    completion(.failure(CustomError.cannotReceiveData), nil)
                    return
                }
                
                guard let completion = completion else { return }
                completion(.success(image), true)
            }.resume()
        }
    }
}
