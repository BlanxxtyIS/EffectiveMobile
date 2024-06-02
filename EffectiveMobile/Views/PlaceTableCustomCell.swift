//
//  PlaceTableCustomCell.swift
//  EffectiveMobile
//
//  Created by Марат Хасанов on 29.05.2024.
//

import UIKit

class PlaceTableCustomCell: UITableViewCell {
    
    static let reuseIdentifier = "PlaceCell"
    
    private lazy var placeImage: UIImageView = {
        let image = UIImage(named: "HardRoad")
        let imageView = UIImageView(image: image)
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var placeNamedLabel: UILabel = {
        let label = UILabel()
        label.text = "Стамбул"
        label.textColor = .bWhite
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var placeInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Популярное направление"
        label.textColor = .bGrey5
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func setupData(placeImage: String, placeName: String, placeInfo: String) {
        self.placeImage.image = UIImage(named: placeImage)
        placeNamedLabel.text = placeName
        placeInfoLabel.text = placeInfo
    }
    
    private func setupUI() {
        contentView.addSubview(placeImage)
        contentView.addSubview(placeNamedLabel)
        contentView.addSubview(placeInfoLabel)
        
        NSLayoutConstraint.activate([
            // Констрейнты для placeImage
            placeImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            placeImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            // Констрейнты для placeNamedLabel
            placeNamedLabel.leadingAnchor.constraint(equalTo: placeImage.trailingAnchor, constant: 16),
            placeNamedLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            placeNamedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Констрейнты для placeInfoLabel
            placeInfoLabel.leadingAnchor.constraint(equalTo: placeNamedLabel.leadingAnchor),
            placeInfoLabel.topAnchor.constraint(equalTo: placeNamedLabel.bottomAnchor, constant: 4),
            placeInfoLabel.trailingAnchor.constraint(equalTo: placeNamedLabel.trailingAnchor),
            placeInfoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
