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

class ViewController: UIViewController, UpdateSolutionFound {
  

    var gamemanager: GameManager!
   
    @IBOutlet weak var lbl_solution: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gamemanager = GameManager()
        self.gamemanager.initGameWith(viewcontroller: self, size: self.view.bounds.size.width)
    }
    
    internal func updateSolution(solutionFound: Int) {
        lbl_solution.text = String(solutionFound)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

