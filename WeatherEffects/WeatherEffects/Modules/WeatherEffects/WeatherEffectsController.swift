//
//  WeatherEffectsController.swift
//  WeatherEffects
//
//  Created by Олег Романов on 20.07.2024.
//

import UIKit

class WeatherEffectsController: UIViewController {
    
    // MARK: Constants
    
    private struct Constants {
        static let layoutMinimumLineSpacing: CGFloat = 8
        static let weatherEffectCellIdentifier: String = "WeatherEffectCell"
        
        static let collectionViewItemWidth: CGFloat = UIScreen.main.bounds.width / 3
        static let collectionViewItemHeight: CGFloat = collectionViewItemWidth
        static let collectionViewHeight: CGFloat = collectionViewItemHeight
    }
    
    // MARK: Instance Properties
    
    private let weatherEffects: [WeatherEffects] = WeatherEffects.allCases
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Constants.layoutMinimumLineSpacing
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WeatherEffectCell.self, forCellWithReuseIdentifier: Constants.weatherEffectCellIdentifier)
        collectionView.layer.cornerRadius = 24
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(collectionView)
    }
    
    // MARK: Constraints
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 32
            ),
            collectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24
            ),
            collectionView.heightAnchor.constraint(
                equalToConstant: Constants.collectionViewHeight
            ),
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension WeatherEffectsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherEffects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.weatherEffectCellIdentifier, for: indexPath) as? WeatherEffectCell
        else {
            return UICollectionViewCell()
        }
        let iconName = weatherEffects[indexPath.item].iconSystemName
        let eventName = weatherEffects[indexPath.item].localized
        cell.configure(with: iconName, and: eventName)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension WeatherEffectsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(weatherEffects[indexPath.item].localized) did tapped")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width - 1
        let width = screenWidth / 3
        let height = width

        return CGSize(width: width, height: height)
    }
}
