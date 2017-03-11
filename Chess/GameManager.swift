//
//  GameManager.swift
//  Chess
//
//  Created by Tuuu on 3/8/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation
import UIKit
class GameManager: UIView
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
    var nQueens:EightQueen!
    var queens = [[Position]]()
    var stepSolutions = [[Step]]()
    let rowTotal = 8
    let colTotal = 8
    
    func initGameWith(viewcontroller: UIViewController, size: CGFloat)
    {
        
        let boardView = Board(frame: CGRect(x: 0,
                                            y: viewcontroller.view.bounds.size.height / 2 - size / 2,
                                            width: size, height: size),
                              rowTotal: rowTotal,
                              colTotal: colTotal)
        viewcontroller.view.addSubview(boardView)
        self.mainView = boardView
        
        let width = self.mainView.frame.width/CGFloat(colTotal)
        self.addPieceSet(rowTotal: 1, colTotal: 1, width: width)
        
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
        moveQueen()
        //        let fromPosition = Position(row: Int((self.fromPosition.text?.components(separatedBy: "-").first)!), col: Int((self.fromPosition.text?.components(separatedBy: "-").last)!))
        //
        //        let toPosition = Position(row: Int((self.toPosition.text?.components(separatedBy: "-").first)!), col: Int((self.toPosition.text?.components(separatedBy: "-").last)!))
        //
        //        var piece: Piece!
        //        for pieceSet in self.pieceSets
        //        {
        //            if let checkPiece = pieceSet.getPieceAt(position: fromPosition)
        //            {
        //                piece = checkPiece
        //                break
        //            }
        //        }
        //        if(piece != nil)
        //        {
        //            piece.moveTo(destination: toPosition)
        //        }
    }
    
    //
    var currentIndexQueen = 0
    var rowSolution = 0
    var colSolution = 0
    var currentSolition = [Step]()
    func removeAllPieces()
    {
        for piece in self.mainView.subviews
        {
            if piece is PieceView
            {
                piece.removeFromSuperview()
            }
        }
    }
    func removeBacktrackedPieces()
    {
        for _ in 0..<self.colTotal/2
        {
            self.mainView.subviews.last?.removeFromSuperview()
        }
    }
    func loop()
    {
        rowSolution = 2
        print("-----------\(self.rowSolution)")
        removeAllPieces()
        currentSolition = self.stepSolutions[self.rowSolution]
        animation()
    }
    func animation()
    {
        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: 2.0, animations: {
            print(self.currentSolition[self.colSolution])
            if(self.currentSolition[self.colSolution].isBackTrack == true)
            {
                self.removeBacktrackedPieces()
            }
            else
            {
                if(self.currentSolition[self.colSolution].isTrue == true)
                {
                    self.pieceSets.first?.addnewQueenAt(position: Position(row: self.currentSolition[self.colSolution].position.row-1, col: self.currentSolition[self.colSolution].position.col-1), isTrue: true)
                }
                else
                {
                    self.pieceSets.first?.addnewQueenAt(position: Position(row: self.currentSolition[self.colSolution].position.row-1, col: self.currentSolition[self.colSolution].position.col-1), isTrue: false)
                }
            }
        }) { (finished) in
            self.colSolution = self.colSolution + 1
            if(self.colSolution == self.currentSolition.count)
            {
                if(self.rowSolution == self.stepSolutions.count-1)
                {
                    return
                }
                self.colSolution = 0
                self.rowSolution = self.rowSolution + 1
                self.loop()
                return
            }
            self.animation()
        }
    }
    func moveQueen(){
        loop()
        //        self.queens = nQueens.queens
        //        if currentIndexQueen == nQueens.queens.count
        //        {
        //            currentIndexQueen = 0
        //        }
        //        var currentQueens = queens[currentIndexQueen]
        ////        print(self.pieceSets.first!.pieceControllers.count)
        //        for (index, pieceController) in self.pieceSets.first!.pieceControllers.enumerated(){
        //
        //            pieceController.pieceModel.moveTo(destination: currentQueens[index])
        //        }
        //        currentIndexQueen = currentIndexQueen + 1
        //        print(currentIndexQueen)
        
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
        //        let blackPieceSet = PieceSet(color: .Black,
        //                                     rowTotal: rowTotal,
        //                                     colTotal: colTotal,
        //                                     width: width)
        //        blackPieceSet.delegate = self
        //        blackPieceSet.addPieces()
        
        nQueens = EightQueen(row: self.rowTotal/2, col: self.rowTotal/2)
        self.stepSolutions = nQueens.stepSolutions
        self.pieceSets = [PieceSet]()
        
        let whitePieceSet = PieceSet(color: .White,
                                     rowTotal: rowTotal,
                                     colTotal: colTotal,
                                     width: width)
        whitePieceSet.delegate = self
        whitePieceSet.addPieces()
        
        self.pieceSetOnTop = PieceColor.White
        
        self.pieceSets.append(whitePieceSet)
        //        self.pieceSets.append(blackPieceSet)
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
    func didFinishAddNewPiece(pieceController: PieceController){
        self.mainView.addSubview(pieceController.pieceView)
    }
}
