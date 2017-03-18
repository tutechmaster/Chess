//
//  ViewController.swift
//  Chess
//
//  Created by Tuuu on 3/8/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
  

    var gamemanager: GameManager!
    var mainViewSize = CGSize()
    var sizeBoard:UITextField!


    @IBOutlet weak var btn_PauseSolution: UIButton!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gamemanager = GameManager()
        btnSizeBoard()
        self.gamemanager.initGameWith(viewcontroller: self, size: self.view.bounds.size.width)
        addSizeBoard()


    }
   

    @IBAction func action_Pause(_ sender: UIButton) {
        self.gamemanager.pause = !self.gamemanager.pause
        
        let title  = self.gamemanager.pause ? "Auto": "Manual"
        btn_PauseSolution.setTitle(title, for: UIControlState())
    }
    
    @objc func draw(sender: UIButton){
        self.gamemanager.boardView.removeFromSuperview()
        self.gamemanager.btnStart.isHidden = true
        self.gamemanager.lblSolutionFound.isHidden = true
        self.gamemanager.rowTotal = Int(self.sizeBoard.text!)!
        self.gamemanager.colTotal = Int(self.sizeBoard.text!)!
        self.gamemanager.initGameWith(viewcontroller: self, size: self.view.bounds.size.width)

        
    }
    
    func btnSizeBoard(){
        let btn = UIButton(frame: CGRect(x: view.bounds.size.width/2-40, y: view.bounds.size.height-50, width: 80, height: 50))
        btn.backgroundColor = UIColor.green.withAlphaComponent(0.5)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.setTitle("Draw", for: .normal)
        btn.addTarget(self, action: #selector(draw(sender:)), for: .touchUpInside)
        view.addSubview(btn)

        
    }

    func addSizeBoard(){
        sizeBoard = UITextField(frame: CGRect(x: view.bounds.size.width/2-40, y: view.bounds.size.height-100, width: 80, height: 50))
        sizeBoard.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        sizeBoard.textColor = UIColor.white
        sizeBoard.placeholder = "Size"
        view.addSubview(sizeBoard)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

