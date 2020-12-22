//
//  FiguresContract.swift
//  AmiiboMarioFigures
//
//  Created by Sergey on 20.12.20.
//

import Foundation

//MARK: - View contract
protocol FiguresView: AnyObject {
    func configure(presenter: FiguresViewPresenter)
    func showFiguresData(figures: [Figure])
    func showMessage(message: String)
}

//MARK: - Presenter contract
protocol FiguresViewPresenter {
    init(view: FiguresView, coordinator: AppCoordinator, service: ServiceLayer)
    func getFiguresData()
    func navigateToDetails(figure: Figure)
}
