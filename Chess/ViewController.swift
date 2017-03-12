//
//  ViewController.swift
//  Chess
//
//  Created by Tuuu on 3/8/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import UIKit
import AVFoundation

protocol UpdateSolutionFound {
    func updateSolution(solutionFound: Int)
}

class ViewController: UIViewController, UpdateSolutionFound, UIGestureRecognizerDelegate {
  

    var gamemanager: GameManager!
    var water = UIImageView()
    var radians = CGFloat()
    var mainViewSize = CGSize()


   
    @IBOutlet weak var lbl_solution: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addWater()
        self.gamemanager = GameManager()
        self.gamemanager.initGameWith(viewcontroller: self, size: self.view.bounds.size.width)
         let timeWater = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(waterRoll), userInfo: nil, repeats: true)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onPan))
        water.isUserInteractionEnabled = true
        water.addGestureRecognizer(panGesture)

    }
    
    internal func updateSolution(solutionFound: Int) {
        lbl_solution.text = String(solutionFound)
    }
    
    func addWater()  {
        
        mainViewSize = self.view.bounds.size
        water = UIImageView(image: UIImage(named: "water.png"))
        water.center = CGPoint(x: mainViewSize.width*0.5, y: mainViewSize.height*0.5 + mainViewSize.width*0.5 + 70)
        self.view.addSubview(water)
    }
    func waterRoll(){
        let deltaAngleWater:CGFloat = 0.1
        radians = radians + deltaAngleWater
        let rotate = CGAffineTransform(rotationAngle: radians)
        water.transform = rotate
    }
    func onPan(panGesture: UIPanGestureRecognizer){
        if (panGesture.state == .began || panGesture.state == .changed ){
            let point = panGesture.location(in: self.view)
            self.water.center = point
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

