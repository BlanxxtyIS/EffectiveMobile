//
//  SearchViewController.swift
//  EffectiveMobile
//
//  Created by Марат Хасанов on 28.05.2024.
//

import UIKit

protocol WhereToGoViewControllerDelegate: AnyObject {
    func didChangeView(to color: UIColor)
}

class AirTicketsViewController: UIViewController {
    
    var airTicketsModel: [AirTicketsModel] = []
    let networkManager = AirTicketsManager()

    //MARK: - Private Properties
    private lazy var loginAccountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .bGrey6
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Поиск дешевых авиабилетов"
        label.textAlignment = .center
        label.widthAnchor.constraint(equalToConstant: 300).isActive = true
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Серый фон
    private lazy var searchBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .bGrey2
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // Фон поиска
    private lazy var searchContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .bGrey4
        view.layer.cornerRadius = 16
        return view
    }()

    // Лупа
    private lazy var searchIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "searchIcon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // Текстовое поле "Откуда"
    private lazy var fromTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16, weight: .bold)
        textField.textColor = .bWhite
        textField.attributedPlaceholder = NSAttributedString(string: "Откуда - Москва", attributes: [NSAttributedString.Key.foregroundColor: UIColor.bGrey6])
        textField.borderStyle = .none
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    // Линия между полями поиска
    private lazy var separatorLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()

    // Текстовое поле "Куда"
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

    // Название коллекции
    private lazy var collectionInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .bWhite
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Музыкально отлететь"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Коллекция
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 130, height: 240) // Устанавливаем размер ячеек
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true // Включаем пейджинг
        collectionView.backgroundColor = .bShadows
        collectionView.register(CustomCollectionMainViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    //Возврщенный стэк (горизонтальная прокрутка)
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var tableViewTickets: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        table.dataSource = self
        table.delegate = self
        table.heightAnchor.constraint(equalToConstant: 288).isActive = true
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var showAllTickets: UIButton = {
        let button = UIButton()
        button.setTitle("Посмотреть все билеты", for: .normal)
        button.setTitleColor(.bWhite, for: .normal)
        button.backgroundColor = .sBlue
        button.addTarget(self, action: #selector(showAllTicketsPressed), for: .touchUpInside)
        button.layer.cornerRadius = 8
        button.heightAnchor.constraint(equalToConstant: 42).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var subscribeToCount: UIButton = {
        let button = UIButton()
        button.setTitle("Подписка нацену", for: .normal)
        button.setTitleColor(.bWhite, for: .normal)
        button.backgroundColor = .bGrey1
        button.layer.cornerRadius = 8
        button.heightAnchor.constraint(equalToConstant: 42).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    //MARK: - Initialized
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Search")
        setupUI()
        networkManager.delegate = self
        networkManager.performRequest()
    }

    //MARK: - Private Methods
    @objc
    private func showAllTicketsPressed() {
        print("Посмотреть все билеты")
    }
    // Обновление после возвращения
    private func setupUpdateUI() {
        view.addSubview(searchContainerView)
        searchContainerView.addSubview(searchIcon)
        searchContainerView.addSubview(fromTextField)
        searchContainerView.addSubview(toTextField)
        searchContainerView.addSubview(separatorLine)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        view.addSubview(tableViewTickets)
        view.addSubview(showAllTickets)
        view.addSubview(subscribeToCount)

        var buttons = [UIButton]()
        for i in 1...4 {
            let button = UIButton(type: .system)
            button.setTitle("Button \(i)", for: .normal)
            button.backgroundColor = .systemBlue
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 16
            button.widthAnchor.constraint(equalToConstant: 105).isActive = true
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }

        NSLayoutConstraint.activate([
            // Установка ограничений для searchContainerView
            searchContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 47),
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

            scrollView.topAnchor.constraint(equalTo: searchContainerView.bottomAnchor, constant: 15),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scrollView.heightAnchor.constraint(equalToConstant: 33),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            stackView.widthAnchor.constraint(equalToConstant: CGFloat(buttons.count) * 105 + CGFloat(buttons.count - 1) * 8),
            
            tableViewTickets.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15),
            tableViewTickets.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableViewTickets.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            showAllTickets.topAnchor.constraint(equalTo: tableViewTickets.bottomAnchor, constant: 18),
            showAllTickets.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            showAllTickets.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            subscribeToCount.topAnchor.constraint(equalTo: showAllTickets.bottomAnchor, constant: 24),
            subscribeToCount.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            subscribeToCount.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    // Основное UI
    private func setupUI() {
        if let savedText = UserDefaults.standard.string(forKey: "lastToText") {
            fromTextField.text = savedText
        }

        view.backgroundColor = .bShadows
        view.addSubview(loginAccountLabel)
        view.addSubview(searchBackgroundView)
        searchBackgroundView.addSubview(searchContainerView)
        searchContainerView.addSubview(searchIcon)
        searchContainerView.addSubview(fromTextField)
        searchContainerView.addSubview(toTextField)
        searchContainerView.addSubview(separatorLine)
        view.addSubview(collectionInfoLabel)
        view.addSubview(collectionView)

        collectionView.dataSource = self
        collectionView.delegate = self
        setupConstraints()
    }

    // Констрейнты
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Установка ограничений для loginAccountLabel
            loginAccountLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 26),
            loginAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            // Установка ограничений для searchBackgroundView
            searchBackgroundView.topAnchor.constraint(equalTo: loginAccountLabel.bottomAnchor, constant: 38),
            searchBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchBackgroundView.heightAnchor.constraint(equalToConstant: 122),

            // Установка ограничений для searchContainerView
            searchContainerView.topAnchor.constraint(equalTo: searchBackgroundView.topAnchor, constant: 16),
            searchContainerView.leadingAnchor.constraint(equalTo: searchBackgroundView.leadingAnchor, constant: 16),
            searchContainerView.trailingAnchor.constraint(equalTo: searchBackgroundView.trailingAnchor, constant: -16),
            searchContainerView.bottomAnchor.constraint(equalTo: searchBackgroundView.bottomAnchor, constant: -16),

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

            collectionInfoLabel.topAnchor.constraint(equalTo: searchBackgroundView.bottomAnchor, constant: 22),
            collectionInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            collectionView.topAnchor.constraint(equalTo: collectionInfoLabel.bottomAnchor, constant: 26),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 213.16),
            collectionView.widthAnchor.constraint(equalToConstant: 642)
        ])
    }
}

//MARK: - UITextFieldDelegate
extension AirTicketsViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacterSet = CharacterSet(charactersIn: "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯабвгдеёжзийклмнопрстуфхцчшщьыъэюя ")
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacterSet.isSuperset(of: characterSet)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == fromTextField {
            UserDefaults.standard.set(textField.text, forKey: "lastToText")
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == toTextField {
            let modalViewController = WhereToGoViewController()
            modalViewController.delegate = self
            present(modalViewController, animated: true)
            return false
        }
        return true
    }
}

//MARK: - UICollectionViewDelegate
extension AirTicketsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 132, height: 213.16) // Размер ячейки
    }
}

//MARK: - UICollectionViewDataSource
extension AirTicketsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        airTicketsModel.count // Количество элементов в ленте
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCollectionMainViewCell
        let networkData = airTicketsModel[indexPath.row]
        let image = UIImage(named: "\(networkData.id)id") ?? UIImage(named: "1id")!
        let imageName = networkData.title
        let pointName = networkData.town
        let price = networkData.value
        cell.setupUI(cellImageView: image, cellImageNamed: imageName, cellToPointName: pointName, cellPrice: price)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension AirTicketsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Выбрали элемент \(indexPath)")
    }
}

//MARK: - UITableViewDataSource
extension AirTicketsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "АЛЛЕ"
        return cell
    }
}

//MARK: - WhereToGoViewControllerDelegate
extension AirTicketsViewController: WhereToGoViewControllerDelegate {
    func didChangeView(to color: UIColor) {
        loginAccountLabel.isHidden = true
        collectionInfoLabel.isHidden = true
        collectionView.isHidden = true
        searchBackgroundView.isHidden = true
        setupUpdateUI()
    }
}

extension AirTicketsViewController: AirTicketsManagerDelegate {
    func getAirTickets(tickets: [AirTicketsModel]) {
        tickets.forEach { ticket in
            airTicketsModel.append(ticket)
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
