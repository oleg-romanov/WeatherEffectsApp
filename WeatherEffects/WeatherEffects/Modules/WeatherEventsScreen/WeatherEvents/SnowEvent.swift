//
//  SnowEvent.swift
//  WeatherEffects
//
//  Created by Олег Романов on 22.07.2024.
//

import UIKit

final class SnowEvent: WeatherEventItem {
    
    func configureEmitterLayer(with bounds: CGRect) -> CAEmitterLayer? {
        let emitterLayer = CAEmitterLayer()
        
        emitterLayer.emitterShape = .line
        emitterLayer.emitterPosition = CGPoint(x: bounds.midX, y: 0)
        emitterLayer.emitterSize = CGSize(width: bounds.size.width, height: 1)
        
        return emitterLayer
    }
    
    func configureEmitterCells() -> [CAEmitterCell]? {
        let snowCell = CAEmitterCell()
        
        snowCell.contents = UIImage(named: "snowflake")?.cgImage
        snowCell.birthRate = 10
        snowCell.velocity = 30
        snowCell.lifetime = Float(UIScreen.main.bounds.height / snowCell.velocity)
        snowCell.velocityRange = 10
        snowCell.emissionLongitude = .pi
        snowCell.scale = 0.1
        snowCell.scaleRange = 0.1
        
        return [snowCell]
    }
    
    func fetchEventName() -> String {
        return WeatherEvents.snow.localized
    }
    
    func fetchEventIcon() -> UIImage {
        return UIImage(systemName: WeatherEvents.snow.iconSystemName) ?? UIImage()
    }
    
    func configureBackgroundColor() -> CGColor? {
        return UIColor(named: ColorNameConstants.steelBlueColor)?.cgColor
    }
}
