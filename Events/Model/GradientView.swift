//
//  GradientView.swift
//  Events
//
//  Created by Joao Paulo Aquino on 2018-08-15.
//  Copyright © 2018 Joao Paulo Aquino. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var mainColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var startAlpha: CGFloat = 1.0 {
        didSet {
            updateView()
        }
    }
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        
        let gradientDarkColor = mainColor.withAlphaComponent(startAlpha).cgColor
        let gradientLightColor = mainColor.withAlphaComponent(0.0).cgColor
        
        layer.colors = [gradientLightColor, gradientDarkColor].map{$0}
    }
}
