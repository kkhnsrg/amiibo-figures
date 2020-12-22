//
//  FiguresViewController.swift
//  AmiiboMarioFigures
//
//  Created by Sergey on 20.12.20.
//

import Foundation
import UIKit

class FiguresViewController: UIViewController {
    
    private var presenter: FiguresViewPresenter!
    
    var figuresArray: [Figure] = []
    
    //MARK: - Views init
    private let figuresCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(FiguresCollectionViewCell.self, forCellWithReuseIdentifier: FiguresCollectionViewCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.backgroundColor = .none
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        arrangeSubviews()
        
        presenter.getFiguresData()
    }
    
}

//MARK: - UI
private extension FiguresViewController {
    
    func setupView() {
        view.backgroundColor = .darkGray
        figuresCollection.dataSource = self
        figuresCollection.delegate = self
    }
    
    func addSubviews() {
        view.addSubview(figuresCollection)
    }
    
    func arrangeSubviews() {
        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            figuresCollection.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            figuresCollection.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            figuresCollection.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            figuresCollection.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
        ])
        
    }
}

//MARK: - View contract
extension FiguresViewController: FiguresView {
    func configure(presenter: FiguresViewPresenter) {
        self.presenter = presenter
    }
    
    func showFiguresData(figures: [Figure]) {
        figuresArray = figures
        print("show figures", figuresArray)

        figuresCollection.reloadData()
    }
    
    func showMessage(message: String) {
        print(message)
    }
}

extension FiguresViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        figuresArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FiguresCollectionViewCell.reuseIdentifier, for: indexPath) as? FiguresCollectionViewCell else {
            return FiguresCollectionViewCell()
        }

        cell.configure(with: figuresArray[indexPath.row])
        cell.styleCell()

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.frame.width - 15) / 2.0, height: (collectionView.frame.width - 15) / 1.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.navigateToDetails(figure: figuresArray[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.backgroundView?.backgroundColor = .lightGray
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.backgroundView?.backgroundColor = .gray

        }
    }

}
