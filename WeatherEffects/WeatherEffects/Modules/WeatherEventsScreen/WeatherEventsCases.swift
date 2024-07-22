//
//  WeatherEventsCases.swift
//  WeatherEffects
//
//  Created by Олег Романов on 20.07.2024.
//

import Foundation

enum WeatherEvents: String, CaseIterable {
    case clear
    case rain
    case heavyRain
    case cloudy
    case storm
    case snow
    case snowWithRain
    case blizzard
    case fog
    case windy
    
    var localized: String {
        get {
            switch self {
                case .clear:
                    return LocalizableStrings.clear
                case .rain:
                    return LocalizableStrings.rain
                case .heavyRain:
                    return LocalizableStrings.heavyRain
                case .cloudy:
                    return LocalizableStrings.cloudy
                case .storm:
                    return LocalizableStrings.storm
                case .snow:
                    return LocalizableStrings.snow
                case .snowWithRain:
                    return LocalizableStrings.snowWithRain
                case .blizzard:
                    return LocalizableStrings.blizzard
                case .fog:
                    return LocalizableStrings.fog
                case .windy:
                    return LocalizableStrings.windy
            }
        }
    }
    
    var iconSystemName: String {
        get {
            switch self {
                case .clear:
                    return "sun.max.fill"
                case .rain:
                    return "cloud.rain.fill"
                case .heavyRain:
                    return "cloud.heavyrain.fill"
                case .cloudy:
                    return "smoke.fill"
                case .storm:
                    return "cloud.bolt.rain.fill"
                case .snow:
                    return "cloud.snow.fill"
                case .snowWithRain:
                    return "cloud.sleet.fill"
                case .blizzard:
                    return "wind.snow"
                case .fog:
                    return "cloud.fog.fill"
                case .windy:
                    return "wind"
            }
        }
    }
}
