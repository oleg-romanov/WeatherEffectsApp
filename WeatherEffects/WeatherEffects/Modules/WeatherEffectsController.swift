//
//  WeatherEffectsController.swift
//  WeatherEffects
//
//  Created by Олег Романов on 20.07.2024.
//

import UIKit

class WeatherEffectsController: UIViewController {
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

enum WeatherEffects: String, CaseIterable {
    case clear
    case rain
    case cloudy
    case thunderStorm
    case snow
    case snowWithRain
    case blizzard
    case fog
    
    var localized: String {
        get {
            switch self {
                case .clear:
                    return LocalizableStrings.clear
                case .rain:
                    return LocalizableStrings.rain
                case .cloudy:
                    return LocalizableStrings.cloudy
                case .thunderStorm:
                    return LocalizableStrings.thunderStorm
                case .snow:
                    return LocalizableStrings.snow
                case .snowWithRain:
                    return LocalizableStrings.snowWithRain
                case .blizzard:
                    return LocalizableStrings.blizzard
                case .fog:
                    return LocalizableStrings.fog
            }
        }
    }
}
