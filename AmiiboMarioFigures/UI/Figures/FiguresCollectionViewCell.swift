//
//  FiguresCollectionViewCell.swift
//  AmiiboMarioFigures
//
//  Created by Sergey on 20.12.20.
//

import Foundation
import UIKit

class FiguresCollectionViewCell: UICollectionViewCell {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 15)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let photoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        arrangeSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        addSubviews()
        arrangeSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(with figure: Figure) {
        nameLabel.text = figure.name
        photoImage.downloaded(from: figure.imageUrl)
    }
}

private extension FiguresCollectionViewCell {
    func addSubviews() {
        addSubview(nameLabel)
        addSubview(photoImage)
    }
    
    func arrangeSubviews() {
        NSLayoutConstraint.activate([
            photoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            photoImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            photoImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0),
            photoImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30.0),
            photoImage.widthAnchor.constraint(equalTo: self.widthAnchor),
            photoImage.heightAnchor.constraint(equalTo: self.widthAnchor, constant: -40.0),
            
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5.0),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5.0),
            nameLabel.topAnchor.constraint(equalTo: photoImage.bottomAnchor, constant: 5.0),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5.0)
        ])
    }
}

extension FiguresCollectionViewCell {
    func styleCell() {
        self.contentView.layer.cornerRadius = 30
        
        self.backgroundView = UIView(frame: self.bounds)
        self.backgroundView?.backgroundColor = UIColor.gray
        self.backgroundView?.layer.cornerRadius = 30
    }
}

extension FiguresCollectionViewCell {
    static var reuseIdentifier: String { String(describing: self) }
}
