//
//  WeatherEffectLayer.swift
//  WeatherEffects
//
//  Created by Олег Романов on 22.07.2024.
//

import UIKit

final class WeatherEffectLayer: CALayer {
    
    // MARK: Initializers
    
    override init() {
        super.init()
        setupStyle()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setupStyle() {
        backgroundColor = UIColor(named: ColorNameConstants.steelBlueColor)?.cgColor
    }
    
    // MARK: Instance Properties
    
    private var contentSublayer: CALayer?
    private var additionalSublayers: [CALayer]?
    
    // MARK: Instance Methods
    
    func configure(with effect: WeatherEffectConfigurable) {
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
        
        if let additionalSublayers = effect.additionalSublayers {
            additionalSublayers.forEach {
                newContentSublayer.addSublayer($0)
            }
        }
        
        let newEmitterLayer = effect.configureEmitterLayer(with: contentSublayer!.bounds)
        newEmitterLayer.emitterCells = effect.configureEmitterCells()
        newContentSublayer.addSublayer(newEmitterLayer)
    }
}
