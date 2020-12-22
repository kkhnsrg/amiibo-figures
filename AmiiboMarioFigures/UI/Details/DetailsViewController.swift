//
//  DetailsViewController.swift
//  AmiiboMarioFigures
//
//  Created by Sergey on 20.12.20.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {

    private var presenter: DetailsViewPresenter!
    
    private var currentFigure: Figure!

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 30)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    private let amiiboSeriesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 20)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let gameSeriesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 20)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 20)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let photoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()
    
    override func viewDidLoad() {
        setupView()
        addSubviews()
        arrangeSubviews()
    }
}

//MARK: - UI
private extension DetailsViewController {
    
    func setupView() {
        view.backgroundColor = .darkGray
        
        nameLabel.text = currentFigure.name
        amiiboSeriesLabel.text = "Amiibo: \(currentFigure.amiiboSeries)"
        gameSeriesLabel.text = "Game: \(currentFigure.gameSeries)"
        typeLabel.text = "Type: \(currentFigure.type)"
        photoImage.downloaded(from: currentFigure.imageUrl)
    }
    
    func addSubviews() {
        view.addSubview(nameLabel)
        view.addSubview(amiiboSeriesLabel)
        view.addSubview(gameSeriesLabel)
        view.addSubview(typeLabel)
        view.addSubview(photoImage)
    }
    
    func arrangeSubviews() {
        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15),
            nameLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30),
            
            photoImage.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 30),
            photoImage.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -30),
            photoImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),

            gameSeriesLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15),
            gameSeriesLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15),
            gameSeriesLabel.topAnchor.constraint(equalTo: photoImage.bottomAnchor, constant: 20),
            
            amiiboSeriesLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15),
            amiiboSeriesLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15),
            amiiboSeriesLabel.topAnchor.constraint(equalTo: gameSeriesLabel.bottomAnchor, constant: 10),
            
            typeLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15),
            typeLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15),
            typeLabel.topAnchor.constraint(equalTo: amiiboSeriesLabel.bottomAnchor, constant: 10),
        ])
        
    }
}

//MARK: - View contract
extension DetailsViewController: DetailsView {
    
    func configure(presenter: DetailsViewPresenter, figure: Figure) {
        self.presenter = presenter
        self.currentFigure = figure
    }
}
