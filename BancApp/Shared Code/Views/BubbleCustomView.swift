//
//  BubbleCustomView.swift
//  BancApp
//
//  Created by Alberto on 3/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import UIKit

@IBDesignable

class BubbleView: UIView {
    
    @IBInspectable var fillColor: UIColor? {
        didSet {
            self.backgroundColor = fillColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.CGColor
        }
    }
}
