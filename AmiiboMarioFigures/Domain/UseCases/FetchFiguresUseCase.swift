//
//  FetchFiguresUseCase.swift
//  AmiiboMarioFigures
//
//  Created by Sergey on 20.12.20.
//

import Foundation

//MARK: - UseCase protocol
protocol FetchFiguresUseCase {
    associatedtype FetchResult: Any
    typealias Completion = (_ result: [Figure], _ success: Bool) -> ()
    
    func execute(completion: @escaping Completion)
}

//MARK: - UseCase implementation
class FetchFiguresUseCaseImpl: FetchFiguresUseCase {
    
    typealias FetchResult = FiguresResponse
    
    private let service: ServiceLayer
    
    init(service: ServiceLayer) {
        self.service = service
    }
    
    func execute(completion: @escaping Completion) {
        service.request(router: .getFigures) { (result: Result<FetchResult>) in
            switch result {
            case .success(let response):
                completion(response.amiibo, true)
            case .failure(let error):
                completion([], false)
                print("Error", error.localizedDescription)
            }
        }
        
    }
}
