//
//  StormEvent.swift
//  WeatherEffects
//
//  Created by Олег Романов on 22.07.2024.
//

import UIKit

final class StormEvent: WeatherEventItem {
    
    func configureEmitterLayer(with bounds: CGRect) -> CAEmitterLayer? {
        let emitterLayer = CAEmitterLayer()
        
        emitterLayer.emitterShape = .line
        emitterLayer.emitterPosition = CGPoint(x: bounds.midX, y: 0)
        emitterLayer.emitterSize = CGSize(width: bounds.size.width, height: 1)
        
        return emitterLayer
    }
    
    func configureEmitterCells() -> [CAEmitterCell]? {
        let stormRainCell = CAEmitterCell()
        
        stormRainCell.contents = CGImage.drawRainDrop()
        stormRainCell.birthRate = 35
        stormRainCell.velocity = 500
        stormRainCell.lifetime =  Float(UIScreen.main.bounds.height / stormRainCell.velocity)
        stormRainCell.velocityRange = 150
        stormRainCell.emissionLongitude = .pi
        stormRainCell.scale = 0.1
        stormRainCell.scaleRange = 0.1
        
        return [stormRainCell]
    }
    
    func fetchEventName() -> String {
        return WeatherEvents.storm.localized
    }
    
    func fetchEventIcon() -> UIImage {
        return UIImage(systemName: WeatherEvents.storm.iconSystemName) ?? UIImage()
    }
    
    func configureBackgroundColor() -> CGColor? {
        return UIColor(named: ColorNameConstants.steelBlueColor)?.cgColor
    }
}
