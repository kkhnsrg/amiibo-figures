//
//  Coordinator.swift
//  AmiiboMarioFigures
//
//  Created by Sergey on 20.12.20.
//

import Foundation

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController {get set}
    
    func start()
}

class AppCoordinator: NSObject, Coordinator {
    
    var navigationController: UINavigationController
    private let service: ServiceLayer
        
    init(navController: UINavigationController) {
        navigationController = navController
        service = ServiceLayer()
    }
    
    func start() {
        
        let vc = FiguresViewController()
        let presenter = FiguresPresenter(view: vc, coordinator: self, service: service)
        vc.configure(presenter: presenter)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateToDetails(figure: Figure) {
        let vc = DetailsViewController()
        let presenter = DetailsPresenter(view: vc, coordinator: self)
        vc.configure(presenter: presenter, figure: figure)
        
        navigationController.interactivePopGestureRecognizer?.delegate = self
        navigationController.interactivePopGestureRecognizer?.isEnabled = true
        
        navigationController.pushViewController(vc, animated: true)
    }
    
}

//MARK: - UIGestureRecognizerDelegate
extension AppCoordinator: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        gestureRecognizer == navigationController.interactivePopGestureRecognizer
    }
}

