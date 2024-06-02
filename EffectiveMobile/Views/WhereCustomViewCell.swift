//
//  WhereCustomViewCell.swift
//  EffectiveMobile
//
//  Created by Марат Хасанов on 29.05.2024.
//

import UIKit

class WhereCustomViewCell: UICollectionViewCell {
    
    private let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cellSelectedImage: UIImageView = {
       let image = UIImage(named: "HardRoad")
        let imageView = UIImageView(image: image)
        imageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let cellImageNamed: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "Сложный маршрут"
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.textColor = .bWhite
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cellView)
        cellView.addSubview(cellSelectedImage)
        cellView.addSubview(cellImageNamed)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCustomCell(image: String, text: String) {
        cellSelectedImage.image = UIImage(named: image)
        cellImageNamed.text = text
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            cellSelectedImage.topAnchor.constraint(equalTo: cellView.topAnchor),
            cellSelectedImage.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 11),
            cellSelectedImage.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -11),
            
            cellImageNamed.topAnchor.constraint(equalTo: cellSelectedImage.bottomAnchor, constant: 8),
            cellImageNamed.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
            cellImageNamed.trailingAnchor.constraint(equalTo: cellView.trailingAnchor)
        ])
    }
}
