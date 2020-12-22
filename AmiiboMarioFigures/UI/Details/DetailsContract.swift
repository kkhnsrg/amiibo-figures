//
//  DetailsContract.swift
//  AmiiboMarioFigures
//
//  Created by Sergey on 20.12.20.
//

import Foundation

//MARK: - View contract
protocol DetailsView: AnyObject {
    func configure(presenter: DetailsViewPresenter, figure: Figure)
}

//MARK: - Presenter contract
protocol DetailsViewPresenter {
    init(view: DetailsView, coordinator: AppCoordinator)
}
