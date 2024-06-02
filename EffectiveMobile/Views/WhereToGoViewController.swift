//
//  WhereToGoViewController.swift
//  EffectiveMobile
//
//  Created by Марат Хасанов on 28.05.2024.
//

import UIKit

class WhereToGoViewController: UIViewController {
    
    weak var delegate: WhereToGoViewControllerDelegate?
        
    private let image = ["HardRoad", "Anywhere", "Weekends", "Tickets"]
    private let imageNamed = ["Сложный маршрут", "Куда угодно", "Выходные", "Горячие билеты"]
    private let tableCountDeleteTime = ["Stambul", "Sochi", "Phuket"]
    
    private lazy var searchContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .bGrey4
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var searchIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "searchIcon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var fromTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16, weight: .bold)
        textField.textColor = .bWhite
        textField.attributedPlaceholder = NSAttributedString(string: "Откуда - Москва", attributes: [NSAttributedString.Key.foregroundColor: UIColor.bGrey6])
        textField.borderStyle = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var separatorLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var toTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16, weight: .bold)
        textField.textColor = .bWhite
        textField.attributedPlaceholder = NSAttributedString(string: "Куда - Турция", attributes: [NSAttributedString.Key.foregroundColor: UIColor.bGrey6])
        textField.borderStyle = .none
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 40
        layout.itemSize = CGSize(width: 70, height: 90)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .bGrey2
        collectionView.register(WhereCustomViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var placeArrivalTableView: UITableView = {
        let table = UITableView()
        table.register(PlaceTableCustomCell.self, forCellReuseIdentifier: PlaceTableCustomCell.reuseIdentifier)
        table.delegate = self
        table.dataSource = self
        table.heightAnchor.constraint(equalToConstant: 216).isActive = true
        table.widthAnchor.constraint(equalToConstant: 328).isActive = true
        table.layer.cornerRadius = 16
        table.backgroundColor = .bGrey4
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bGrey2
        setupUI()
        setupConstraints()
        collectionView.delegate = self
        collectionView.dataSource = self
        placeArrivalTableView.delegate = self
        placeArrivalTableView.dataSource = self
    }
    
    @objc
    private func hardRoadButtonPressed() {
        print("придумаем что нибудь")
    }
    
    private func setupUI() {
        view.addSubview(searchContainerView)
        searchContainerView.addSubview(searchIcon)
        searchContainerView.addSubview(fromTextField)
        searchContainerView.addSubview(toTextField)
        searchContainerView.addSubview(separatorLine)
        view.addSubview(collectionView)
        view.addSubview(placeArrivalTableView)
    }
    
    private func setupConstraints() {
        // Установка ограничений для searchContainerView
        NSLayoutConstraint.activate([
            searchContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 46),
            searchContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchContainerView.heightAnchor.constraint(equalToConstant: 96),
            
            // Установка ограничений для searchIcon
            searchIcon.leadingAnchor.constraint(equalTo: searchContainerView.leadingAnchor, constant: 8),
            searchIcon.centerYAnchor.constraint(equalTo: searchContainerView.centerYAnchor),
            searchIcon.widthAnchor.constraint(equalToConstant: 24),
            searchIcon.heightAnchor.constraint(equalToConstant: 24),
            
            // Установка ограничений для fromTextField
            fromTextField.topAnchor.constraint(equalTo: searchContainerView.topAnchor, constant: 16),
            fromTextField.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 17),
            fromTextField.bottomAnchor.constraint(equalTo: separatorLine.topAnchor, constant: -8),
            fromTextField.trailingAnchor.constraint(equalTo: searchContainerView.trailingAnchor, constant: -8),
            fromTextField.heightAnchor.constraint(equalToConstant: 20.8),
            
            // Установка ограничений для separatorLine
            separatorLine.topAnchor.constraint(equalTo: fromTextField.bottomAnchor),
            separatorLine.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 16),
            separatorLine.trailingAnchor.constraint(equalTo: searchContainerView.trailingAnchor, constant: -16),
            separatorLine.heightAnchor.constraint(equalToConstant: 1),
            
            // Установка ограничений для toTextField
            toTextField.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 8),
            toTextField.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 17),
            toTextField.trailingAnchor.constraint(equalTo: searchContainerView.trailingAnchor, constant: -8),
            toTextField.bottomAnchor.constraint(equalTo: searchContainerView.bottomAnchor, constant: -16),
            toTextField.heightAnchor.constraint(equalToConstant: 20.8),
                        
            collectionView.topAnchor.constraint(equalTo: searchContainerView.bottomAnchor, constant: 26),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19),
            collectionView.heightAnchor.constraint(equalToConstant: 90),
            
            placeArrivalTableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 26),
            placeArrivalTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            placeArrivalTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}
//MARK: - UICollectionDelegate
extension WhereToGoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 90) // Размер ячейки
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Выбрали элемент \(image[indexPath.row])")
        let index = image[indexPath.row]
        switch index {
        case "Anywhere":
            toTextField.text = "Куда угодно"
        default:
            dismiss(animated: true)
        }
    }
}

//MARK: - UICollectionDataSource
extension WhereToGoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 4
        }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! WhereCustomViewCell
        cell.setupCustomCell(image: image[indexPath.row], text: imageNamed[indexPath.row])
        return cell
    }
}

//MARK: - UITableViewDelegate
extension WhereToGoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        toTextField.text = tableCountDeleteTime[indexPath.row]
        print("Выбрали элемент \(indexPath.row)")
    }
}

//MARK: - UITableViewDataSource
extension WhereToGoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableCountDeleteTime.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceTableCustomCell.reuseIdentifier, for: indexPath) as? PlaceTableCustomCell else { return UITableViewCell() }
        cell.setupData(placeImage: tableCountDeleteTime[indexPath.row], placeName: tableCountDeleteTime[indexPath.row], placeInfo: tableCountDeleteTime[indexPath.row])
        cell.backgroundColor = .bGrey4
        cell.selectionStyle = .none
        return cell
    }
}

//MARK: - UITextFieldDelegate
extension WhereToGoViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == toTextField, let text = textField.text, !text.isEmpty {
            presentCountySelectedViewController()
        }
    }

    private func presentCountySelectedViewController() {
        delegate?.didChangeView(to: .red)
        dismiss(animated: true)
    }
}
