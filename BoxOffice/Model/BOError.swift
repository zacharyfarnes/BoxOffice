//
//  BOError.swift
//  BoxOffice
//
//  Created by Zachary Farnes on 26/12/2023.
//

import Foundation

enum BOError: Error {
    case invalidURL, invalidResponse, invalidData
    
    var alertMessage: String {
        switch self {
        case .invalidURL:
            return "The URL for obtaining movies is invalid."
        case .invalidResponse:
            return "The response received from the server is invalid."
        case .invalidData:
            return "The data obtained from the server is invalid."
        }
    }
}
