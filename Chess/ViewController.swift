//
//  ViewController.swift
//  Chess
//
//  Created by Tuuu on 3/8/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var gamemanager: GameManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gamemanager = GameManager()
        self.gamemanager.initGameWith(viewcontroller: self, size: self.view.bounds.size.width)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

