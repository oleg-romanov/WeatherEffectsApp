//
//  WeatherEventsController.swift
//  WeatherEffects
//
//  Created by Олег Романов on 20.07.2024.
//

import UIKit

class WeatherEventsController: UIViewController {
    
    // MARK: Constants
    
    private struct Constants {
        static let layoutMinimumLineSpacing: CGFloat = 8
        static let weatherEffectCellIdentifier: String = "WeatherEffectCell"
        
        static let collectionViewItemWidth: CGFloat = UIScreen.main.bounds.width / 3
        static let collectionViewItemHeight: CGFloat = collectionViewItemWidth
        static let collectionViewHeight: CGFloat = collectionViewItemHeight
        
        static let collectionViewTopInset: CGFloat = 32
        static let collectionViewleadingInset: CGFloat = 24
        static let collectionViewTrailingInset: CGFloat = 24
    }
    
    // MARK: Instance Properties
    
    private let effectLayer = WeatherEffectLayer()
    
    private var weatherEvents = [WeatherEventItem]()
    
    private var selectedIndexPath: IndexPath?
    
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
        collectionView.register(WeatherEventCell.self, forCellWithReuseIdentifier: Constants.weatherEffectCellIdentifier)
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selectRandomCell()
    }
    
    // MARK: Setup
    
    private func setup() {
        setupEffectLayer()
        setupWeatherEvents()
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(collectionView)
    }
    
    private func setupEffectLayer() {
        effectLayer.frame = view.bounds
        view.layer.addSublayer(effectLayer)
    }
    
    private func setupWeatherEvents() {
        let clearEvent = ClearEvent()
        let rainEvent = RainEvent()
        let heavyRainEvent = HeavyRainEvent()
        let cloudyEvent = CloudyEvent()
        let stormEvent = StormEvent()
        let snowEvent = SnowEvent()
        let snowWithRainEvent = SnowWithRainEvent()
        let blizzardEvent = BlizzardEvent()
        let fogEvent = FogEvent()
        let windyEvent = WindyEvent()
        
        weatherEvents.append(clearEvent)
        weatherEvents.append(rainEvent)
        weatherEvents.append(heavyRainEvent)
        weatherEvents.append(cloudyEvent)
        weatherEvents.append(stormEvent)
        weatherEvents.append(snowEvent)
        weatherEvents.append(snowWithRainEvent)
        weatherEvents.append(blizzardEvent)
        weatherEvents.append(fogEvent)
        weatherEvents.append(windyEvent)
    }
    
    // MARK: Constraints
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Constants.collectionViewTopInset
            ),
            collectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.collectionViewleadingInset
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.collectionViewTrailingInset
            ),
            collectionView.heightAnchor.constraint(
                equalToConstant: Constants.collectionViewHeight
            ),
        ])
    }
    
    // MARK: Instance Methods
    
    private func selectRandomCell() {
        guard collectionView.numberOfItems(inSection: 0) > 0 else { return }
        
        let randomIndex = Int.random(in: 0..<collectionView.numberOfItems(inSection: 0))
        
        let indexPath = IndexPath(item: randomIndex, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        collectionView.delegate?.collectionView?(collectionView, didSelectItemAt: indexPath)
    }
}

// MARK: - UICollectionViewDataSource

extension WeatherEventsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherEvents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.weatherEffectCellIdentifier, for: indexPath) as? WeatherEventCell
        else {
            return UICollectionViewCell()
        }
        
        let weatherEventItem = weatherEvents[indexPath.item]
        let icon = weatherEventItem.fetchEventIcon()
        let eventName = weatherEventItem.fetchEventName()
        
        cell.configure(with: icon, and: eventName)
        
        cell.isActive = (indexPath == selectedIndexPath)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension WeatherEventsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let previousIndexPath = selectedIndexPath {
            if let previousCell = collectionView.cellForItem(at: previousIndexPath) as? WeatherEventCell {
                previousCell.isActive = false
            }
        }
        
        selectedIndexPath = indexPath
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? WeatherEventCell {
            selectedCell.isActive = true
        }
        
        effectLayer.configure(with: weatherEvents[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width - 1
        let width = screenWidth / 3
        let height = width
        
        return CGSize(width: width, height: height)
    }
}
