//
//  WeatherEffectLayer.swift
//  WeatherEffects
//
//  Created by Олег Романов on 22.07.2024.
//

import UIKit

final class WeatherEffectLayer: CALayer {
    
    // MARK: Setup
    
    func setupStyle(with color: CGColor? = nil) {
        backgroundColor = color
    }
    
    // MARK: Instance Properties
    
    private var contentSublayer: CALayer?
    
    // MARK: Instance Methods
    
    func configure(with effect: WeatherEffectConfigurable) {
        if let backgroundColor = effect.configureBackgroundColor() {
            setupStyle(with: backgroundColor)
        }
        
        if let oldContentSublayer = contentSublayer {
            let fadeOutAnimation = CABasicAnimation(keyPath: "opacity")
            fadeOutAnimation.fromValue = 1.0
            fadeOutAnimation.toValue = 0.0
            fadeOutAnimation.duration = 0.8
            fadeOutAnimation.isRemovedOnCompletion = false
            fadeOutAnimation.fillMode = .forwards
            
            oldContentSublayer.add(fadeOutAnimation, forKey: "fadeOut")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + fadeOutAnimation.duration) {
                oldContentSublayer.removeFromSuperlayer()
            }
        }
        
        let newContentSublayer = CALayer()
        newContentSublayer.frame = bounds
        addSublayer(newContentSublayer)
        contentSublayer = newContentSublayer
        
        if let additionalSublayers = effect.configureAdditionalSublayers(on: bounds) {
            additionalSublayers.forEach {
                newContentSublayer.addSublayer($0)
            }
        }
        
        if let newEmitterLayer = effect.configureEmitterLayer(with: bounds) {
            newEmitterLayer.emitterCells = effect.configureEmitterCells()
            newContentSublayer.addSublayer(newEmitterLayer)
        }
    }
}
