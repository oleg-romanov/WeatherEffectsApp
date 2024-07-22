//
//  FogEvent.swift
//  WeatherEffects
//
//  Created by Олег Романов on 22.07.2024.
//

import UIKit

final class FogEvent: WeatherEventItem {
    
    func configureEmitterLayer(with bounds: CGRect) -> CAEmitterLayer {
        let emitterLayer = CAEmitterLayer()
        
        emitterLayer.emitterShape = .rectangle
        emitterLayer.emitterPosition = CGPoint(x: bounds.minX - bounds.midX, y: bounds.maxY)
        emitterLayer.emitterSize = CGSize(width: bounds.size.width, height: bounds.size.height)
        
        return emitterLayer
    }
    
    func configureEmitterCells() -> [CAEmitterCell] {
        let fogCell = CAEmitterCell()
        
        let cgImg = CGImage.blurCGImage((UIImage(named: "fog")?.cgImage)!, radius: 50)
        fogCell.contents = cgImg
        fogCell.birthRate = 10
        fogCell.lifetime = 150.0
        fogCell.velocity = 20
        fogCell.velocityRange = 10
        fogCell.emissionLongitude = .pi * 2
        fogCell.scale = 0.3
        fogCell.scaleRange = 0.5
        
        return [fogCell]
    }
    
    func fetchEventName() -> String {
        return WeatherEvents.fog.localized
    }
    
    func fetchEventIcon() -> UIImage {
        return UIImage(systemName: WeatherEvents.fog.iconSystemName) ?? UIImage()
    }
}
