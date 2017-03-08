//
//  GameManager.swift
//  Chess
//
//  Created by Tuuu on 3/8/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation
import UIKit
class GameManager
{
    var playedMoves: [Move]!
    var turn: PieceColor!
    var players: [Player]!
    var result: Result!
    var checkStatus: CheckStatus!
    
    func initGameWith(viewcontroller: UIViewController, size: CGFloat)
    {
        let boardView = Board(frame: CGRect(x: 0, y: viewcontroller.view.bounds.size.height / 2 - size / 2, width: size, height: size), rowTotal: 8, colTotal: 8)
        viewcontroller.view.addSubview(boardView)
        
    }
    func addMove()
    {
    }
    func create()
    {
    }
    func isEnded()
    {}
    func isChecked()
    {}
    func operation()
    {}
    func isCheckMated()
    {
    }
    
}
