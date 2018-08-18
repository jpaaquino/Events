//
//  GradientView.swift
//  Events
//
//  Created by Joao Paulo Aquino on 2018-08-15.
//  Copyright © 2018 Joao Paulo Aquino. All rights reserved.
//

import UIKit

// Gradient View used to darken the images to make the event name readable. Without this the contrast with the white text was making the text hard to read on a light background. This is setup as a gradient so that the bottom of the image where the text is is darker but it gets lighter as you move upwards so that the image looks clearer.
//Used IBDesignable so that the color and alpha adjustments can be made on Storyboard and we can see the changes in real time.
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
