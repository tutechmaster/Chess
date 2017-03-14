//
//  Animation.swift
//  Chess
//
//  Created by TTung on 3/13/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation
import UIKit

class ViewAnimation {
    
    weak var views:UIView!
    var duration:TimeInterval!
    var solution:[[Position]]!
    var rowTotal = 8
    var colTotal = 8
    var pause: Bool = false{
        didSet{
            if pause == false{
                animation()
            }
        }
    }
    
    public init() {
        
    }
    
    public func animation(){
        
            guard !pause else {
                return
            }
        let animations = {
            // Animate
        }
        let completion = { (finished: Bool) in
            // Completion
            
        }
        
        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: duration, animations: animations, completion: completion)
    }
    
    public func loop(){
        animation()
    }
    
    
    
    
    
}
