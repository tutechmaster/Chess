//
//  Square.swift
//  Chess
//
//  Created by Tuuu on 3/8/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation
import UIKit
class Square: UIView
{
    var row: Int!
    var col: Int!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
    
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        drawCell(cellSize: frame.width, color: color.cgColor)
        
    }
    
    func drawCell(cellSize: CGFloat, color: CGColor){
        
        let cell = UIView(frame: self.frame)
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = cell.bounds
        maskLayer.path = UIBezierPath(rect: cell.bounds).cgPath
        maskLayer.opacity = 0.7
        cell.layer.mask = maskLayer
        
        let borderLayer = CAShapeLayer()
        borderLayer.path = maskLayer.path
        borderLayer.fillColor = color
        borderLayer.strokeColor = UIColor.black.cgColor
        borderLayer.lineWidth = 2
        borderLayer.frame = cell.bounds
        
        self.layer.addSublayer(borderLayer)
        
    }
}
