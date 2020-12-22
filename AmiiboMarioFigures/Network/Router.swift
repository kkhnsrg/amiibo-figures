//
//  Router.swift
//  AmiiboMarioFigures
//
//  Created by Sergey on 21.12.20.
//

import Foundation

//MARK: - Characters
enum Characters: String {
    case mario = "Mario"
}

//MARK: - Methods
enum HTTPMethod: String {
    case get = "GET"
}

//MARK: - Schemes
enum Scheme: String {
    case https = "https"
}

enum Router {
    
    //MARK: - Router cases
    case getFigures
    
    //MARK: - Router schemes
    var scheme: Scheme {
        switch self {
        case .getFigures:
            return .https
        }
    }
    
    //MARK: - Router hosts
    var host: String {
        switch self {
        case .getFigures:
            return "www.amiiboapi.com"
        }
    }
    
    //MARK: - Router paths
    var path: String {
        switch self {
        case .getFigures:
            return "/api/amiibo"
        }
    }
    
    //MARK: - Router params
    var parameters: [URLQueryItem] {
        switch self {
        case .getFigures:
            return [URLQueryItem(name: "character", value: Characters.mario.rawValue)]
        }
    }
    
    //MARK: - Router methods
    var method: HTTPMethod {
        switch self {
        case .getFigures:
            return .get
        }
    }
}
