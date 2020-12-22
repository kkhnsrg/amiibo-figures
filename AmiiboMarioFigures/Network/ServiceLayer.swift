//
//  ServiceLayer.swift
//  AmiiboMarioFigures
//
//  Created by Sergey on 21.12.20.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

class ServiceLayer {
    
    var urlSession = URLSession.shared
    
    func request<T: Codable>(router: Router, completion: @escaping (Result<T>) -> Void) {
        
        var components = URLComponents()
        
        components.scheme = router.scheme.rawValue
        components.host = router.host
        components.path = router.path
        components.queryItems = router.parameters
        
        guard let url = components.url else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method.rawValue
        
        load(urlRequest: urlRequest, completion: completion)
    }
    
    private func load<T: Codable>(urlRequest: URLRequest, completion: @escaping (Result<T>) -> Void) {
        call(urlRequest) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let resp = try decoder.decode(T.self, from: data)
                    completion(.success(resp))
                }
                catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func call(_ request: URLRequest, deliverQueue: DispatchQueue = DispatchQueue.main, completion: @escaping (Result<Data>) -> Void) {
        urlSession.dataTask(with: request) { (data, _, error) in
            if let error = error {
                deliverQueue.async {
                    completion(.failure(error))
                }
            } else if let data = data {
                deliverQueue.async {
                    completion(.success(data))
                }
            }
        }.resume()
    }
}
