//
//  DetailsPresenter.swift
//  AmiiboMarioFigures
//
//  Created by Sergey on 20.12.20.
//

import Foundation

class DetailsPresenter: DetailsViewPresenter {
    
    private unowned var view: DetailsView!
    private var coordinator: AppCoordinator!
    
    required init(view: DetailsView, coordinator: AppCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}
