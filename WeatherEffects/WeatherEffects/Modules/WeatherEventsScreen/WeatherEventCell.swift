//
//  WeatherEffectCell.swift
//  WeatherEffects
//
//  Created by Олег Романов on 20.07.2024.
//

import UIKit

final class WeatherEventCell: UICollectionViewCell {
    
    // MARK: Constants
    
    private struct Constants {
        static let eventNameLabelNumberOfLines: Int = 2
    }
    
    // MARK: Instance Properties
    
    var isActive: Bool = false {
        didSet {
            updateBorder()
        }
    }
    
    private lazy var eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var eventNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = Constants.eventNameLabelNumberOfLines
        label.font = UIFont.semiboldTitle
        label.textColor = UIColor(named: ColorNameConstants.mainTextColor)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        setupStyle()
        addSubviews()
        makeConstraints()
    }
    
    // MARK: Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        layer.borderColor = UIColor.clear.cgColor
        layer.borderWidth = 0.0
    }
    
    // MARK: Setup
    
    private func setupStyle() {
        backgroundColor = UIColor(named: ColorNameConstants.lightBlueColor)
        layer.cornerRadius = 24
    }
    
    private func addSubviews() {
        contentView.addSubview(eventImageView)
        contentView.addSubview(eventNameLabel)
    }
    
    // MARK: Constraints
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            eventImageView.heightAnchor.constraint(
                equalToConstant: UIScreen.main.bounds.width / 6
            ),
            eventImageView.widthAnchor.constraint(
                equalTo: eventImageView.heightAnchor
            ),
            eventImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 8
            ),
            eventImageView.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),
            
            eventNameLabel.topAnchor.constraint(
                equalTo: eventImageView.bottomAnchor,
                constant: 4
            ),
            eventNameLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 8
            ),
            eventNameLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -8
            ),
            eventNameLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -8
            )
        ])
    }
    
    // MARK: Private Methods
    
    private func updateBorder() {
        if isActive {
            layer.borderColor = UIColor.white.cgColor
            layer.borderWidth = 2.0
        } else {
            layer.borderColor = UIColor.clear.cgColor
            layer.borderWidth = 0.0
        }
    }
    
    // MARK: Internal Methods
    
    func configure(with icon: UIImage, and eventName: String) {
        eventImageView.image = icon
        eventNameLabel.text = eventName
    }
}
