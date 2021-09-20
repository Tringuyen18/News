//
//  Networking.swift
//  Networking
//
//  Created by Nguyễn Trí on 17/09/2021.
//

import Foundation
import UIKit

class Networking {
    
    // MARK: - Singleton Pattern
    private static var sharedNetworking: Networking = {
        let networking = Networking()
        return networking
    }()
    
    class func shared() -> Networking {
        return sharedNetworking
    }
    
    private init() {}
    
    // MARK: - request
    func request(url: String, completion: @escaping (Data?, APIError?) -> Void) {
        guard let url = URL(string: url) else {
            let error = APIError.error("URL error")
            completion(nil, error)
            return
        }
        
        let config = URLSessionConfiguration.ephemeral
        config.waitsForConnectivity = true
        
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, APIError.error(error.localizedDescription))
                } else {
                    if let data = data {
                        completion(data, nil)
                    } else {
                        completion(nil, APIError.error("data format is error"))
                    }
                }
            }
        }
        task.resume()
    }
    
    // MARK: - Dowload
    func dowloadImage(url: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }
        
        let config = URLSessionConfiguration.ephemeral
        config.waitsForConnectivity = true
        
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let _ = error {
                    completion(nil)
                } else {
                    if let data = data {
                        let image = UIImage(data: data)
                        completion(image)
                    } else {
                        completion(nil)
                    }
                }
            }
        }
        task.resume()
    }
}
