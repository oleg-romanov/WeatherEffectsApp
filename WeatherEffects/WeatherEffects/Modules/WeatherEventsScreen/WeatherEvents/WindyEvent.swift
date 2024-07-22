//
//  WindyEvent.swift
//  WeatherEffects
//
//  Created by Олег Романов on 22.07.2024.
//

import UIKit

final class WindyEvent: WeatherEventItem {
    
    func configureEmitterLayer(with bounds: CGRect) -> CAEmitterLayer? {
        let emitterLayer = CAEmitterLayer()
        
        emitterLayer.emitterShape = .rectangle
        emitterLayer.emitterPosition = CGPoint(x: bounds.maxX, y: bounds.midY)
        emitterLayer.emitterSize = CGSize(width: bounds.size.width, height: bounds.size.height)
        
        return emitterLayer
    }
    
    func configureEmitterCells() -> [CAEmitterCell]? {
        let windyPointsCell = CAEmitterCell()
        let windyLinesCell = CAEmitterCell()
 
        windyPointsCell.contents = CGImage.drawPoint()
        windyPointsCell.birthRate = 30
        windyPointsCell.lifetime = 5
        windyPointsCell.velocity = 850
        windyPointsCell.velocityRange = 200
        windyPointsCell.emissionLongitude = .pi
        windyPointsCell.emissionRange = 0.5
        windyPointsCell.scale = 0.1
        windyPointsCell.scaleRange = 0.1

        windyLinesCell.contents = CGImage.drawLine()
        windyLinesCell.birthRate = 10
        windyLinesCell.lifetime = 5
        windyLinesCell.velocity = 850
        windyLinesCell.velocityRange = 200
        windyLinesCell.emissionLongitude = .pi
        windyLinesCell.emissionRange = 0.1
        windyLinesCell.scale = 0.1
        windyLinesCell.scaleRange = 0.1
        
        return [windyPointsCell, windyLinesCell]
    }
    
    func fetchEventName() -> String {
        return WeatherEvents.windy.localized
    }
    
    func fetchEventIcon() -> UIImage {
        return UIImage(systemName: WeatherEvents.windy.iconSystemName) ?? UIImage()
    }
    
    func configureBackgroundColor() -> CGColor? {
        return UIColor(named: ColorNameConstants.lightBlueColor)?.cgColor
    }
}
