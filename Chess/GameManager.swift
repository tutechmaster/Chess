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
    var pieceSets:[PieceSet]! // 1-->2
    var pieceSetOnTop: PieceColor!
    var mainView: UIView!
    
    func initGameWith(viewcontroller: UIViewController, size: CGFloat)
    {
        self.pieceSets = [PieceSet]()
        let boardView = Board(frame: CGRect(x: 0,
                                            y: viewcontroller.view.bounds.size.height / 2 - size / 2,
                                            width: size, height: size),
                                            rowTotal: 8,
                                            colTotal: 8)
        viewcontroller.view.addSubview(boardView)
        self.mainView = boardView
        
        let width = self.mainView.frame.width/CGFloat(8)
        self.addPieceSet(rowTotal: 8, colTotal: 8, width: width)
        
        
    }
    private func addPieceSet(rowTotal: Int, colTotal: Int, width: CGFloat)
    {
        let blackPieceSet = PieceSet(color: .Black,
                                     rowTotal: rowTotal,
                                     colTotal: colTotal,
                                     width: width)
        blackPieceSet.delegate = self
        blackPieceSet.addPieces()
        
        let whitePieceSet = PieceSet(color: .White,
                                     rowTotal: rowTotal,
                                     colTotal: colTotal,
                                     width: width)
        whitePieceSet.delegate = self
        whitePieceSet.addPieces()
        
        self.pieceSetOnTop = PieceColor.White
        
        self.pieceSets.append(whitePieceSet)
        self.pieceSets.append(blackPieceSet)
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
extension GameManager: PieceSetDelegate
{
    func didFinishInitPieceSet(pieceControllers: [PieceController]) {
        for pieceController in pieceControllers
        {
            self.mainView.addSubview(pieceController.pieceView)
        }
    }
}
