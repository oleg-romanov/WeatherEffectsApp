//
//  WeatherEffectConfigurable.swift
//  WeatherEffects
//
//  Created by Олег Романов on 22.07.2024.
//

import UIKit

typealias WeatherEventItem = WeatherEffectConfigurable & WeatherEventConfigurable

protocol WeatherEffectConfigurable {
    func configureEmitterLayer(with bounds: CGRect) -> CAEmitterLayer
    func configureEmitterCells() -> [CAEmitterCell]
    
    var additionalSublayers: [CALayer]? { get }
}

extension WeatherEffectConfigurable {
    var additionalSublayers: [CALayer]? {
        return nil
    }
}

protocol WeatherEventConfigurable {
    func fetchEventName() -> String
    func fetchEventIcon() -> UIImage
}
