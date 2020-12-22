//
//  FiguresPresenter.swift
//  AmiiboMarioFigures
//
//  Created by Sergey on 20.12.20.
//

import Foundation

class FiguresPresenter: FiguresViewPresenter {
    
    private unowned var view: FiguresView!
    private var coordinator: AppCoordinator!
    
    //MARK: - UseCases
    private var fetchFigures: FetchFiguresUseCaseImpl
    
    required init(view: FiguresView, coordinator: AppCoordinator, service: ServiceLayer) {
        self.view = view
        self.coordinator = coordinator
        fetchFigures = FetchFiguresUseCaseImpl(service: service)
    }
    
    func getFiguresData() {

        fetchFigures.execute() { data, success in
            if(success) {
                self.view.showFiguresData(figures: data)
            } else {
                self.view.showMessage(message: "Error")
            }
        }
    }
    
    func navigateToDetails(figure: Figure) {
        coordinator.navigateToDetails(figure: figure)
    }
}
