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
    var fromPosition: UITextField!
    var toPosition: UITextField!
    
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
        
        self.addBtnMove(toView: viewcontroller.view)
        self.addTextField(toView: viewcontroller.view)
        
        
    }
    func addBtnMove(toView view: UIView)
    {
        let btn = UIButton(frame: CGRect(x: 20, y: 50, width: 50, height: 30))
        btn.backgroundColor = UIColor.black
        btn.titleLabel?.textColor = UIColor.white
        btn.setTitle("Move", for: .normal)
        btn.addTarget(self, action: #selector(move(sender:)), for: .touchUpInside)
        view.addSubview(btn)
    }
    @objc func move(sender: UIButton)
    {
        let fromPosition = Position(row: Int((self.fromPosition.text?.components(separatedBy: "-").first)!), col: Int((self.fromPosition.text?.components(separatedBy: "-").last)!))
        
        let toPosition = Position(row: Int((self.toPosition.text?.components(separatedBy: "-").first)!), col: Int((self.toPosition.text?.components(separatedBy: "-").last)!))
        
        var piece: Piece!
        for pieceSet in self.pieceSets
        {
            if let checkPiece = pieceSet.getPieceAt(position: fromPosition)
            {
                piece = checkPiece
                break
            }
        }
        if(piece != nil)
        {
            piece.moveTo(destination: toPosition)
        }
    }
    func addTextField(toView view: UIView)
    {
        fromPosition = UITextField(frame: CGRect(x: 80, y: 50, width: 60, height: 30))
        fromPosition.backgroundColor = UIColor.gray
        fromPosition.textColor = UIColor.white
        fromPosition.placeholder = "row-col"
        
        toPosition = UITextField(frame: CGRect(x: 150, y: 50, width: 60, height: 30))
        toPosition.backgroundColor = UIColor.gray
        toPosition.textColor = UIColor.white
        toPosition.placeholder = "row-col"
        
        view.addSubview(fromPosition)
        view.addSubview(toPosition)
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
