//
//  CustomCollectionViewCell.swift
//  EffectiveMobile
//
//  Created by Марат Хасанов on 28.05.2024.
//

import UIKit

class CustomCollectionMainViewCell: UICollectionViewCell {
    
    private let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .bShadows
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cellImageView: UIImageView = {
        let image = UIImage(named: "airTicketsIcon")
        let imageView = UIImageView(image: image)
        imageView.heightAnchor.constraint(equalToConstant: 133.16).isActive = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let cellImageNamed: UILabel = {
        let label = UILabel()
        label.text = "Die Antwoord"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .bWhite
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cellToPointName: UILabel = {
        let label = UILabel()
        label.text = "Будапешт"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .bWhite
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cellPrice: UILabel = {
        let label = UILabel()
        label.text = "Самолет от 22 264 Р"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .bWhite
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cellView)
        cellView.addSubview(cellImageView)
        cellView.addSubview(cellImageNamed)
        cellView.addSubview(cellToPointName)
        cellView.addSubview(cellPrice)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(cellImageView: UIImage, cellImageNamed: String, cellToPointName: String, cellPrice: Int) {
        self.cellImageView.image = cellImageView
        self.cellImageNamed.text = cellImageNamed
        self.cellToPointName.text = cellToPointName
        self.cellPrice.text = "от \(cellPrice)"
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            cellImageView.topAnchor.constraint(equalTo: cellView.topAnchor),
            cellImageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
            cellImageView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
            
            cellImageNamed.topAnchor.constraint(equalTo: cellImageView.bottomAnchor, constant: 8),
            cellImageNamed.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
            
            cellToPointName.topAnchor.constraint(equalTo: cellImageNamed.bottomAnchor, constant: 8),
            cellToPointName.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
            
            cellPrice.topAnchor.constraint(equalTo: cellToPointName.bottomAnchor, constant: 4),
            cellPrice.leadingAnchor.constraint(equalTo: cellView.leadingAnchor)
        ])
    }
}
