//
//  API.swift
//  API
//
//  Created by Nguyễn Trí on 17/09/2021.
//

import Foundation

typealias Completion = (Bool, String) -> Void

enum APIError: Error {
    case error(String)
    case errorURL
    
    var localizedDescription: String {
        switch self {
        case .error(let string):
            return string
        case .errorURL:
            return "URL string is error"
        }
    }
}


