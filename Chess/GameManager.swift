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
    let rowTotal = 4
    let colTotal = 4
    var dem = 0
    var delegate: UpdateSolutionFound!
    
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
        self.addPieceSet(rowTotal: rowTotal, colTotal: colTotal, width: width)
        
        self.addBtnMove(toView: viewcontroller.view)
        self.addSolutionText(toView: viewcontroller.view)
        //        self.addTextField(toView: viewcontroller.view)
        
        
    }
    
    func countSolution(){
        self.dem = 0
        delegate.updateSolution(solutionFound: self.dem)
    }
    
    
    func addSolutionText(toView view: UIView){
        let lbl = UILabel(frame: CGRect(x: view.bounds.size.width/2-120, y: 90, width: 120, height: 30))
        lbl.text = "Solution Found: "
        view.addSubview(lbl)
        
    }
    
    
    func addBtnMove(toView view: UIView)
    {
        let btn = UIButton(frame: CGRect(x: view.bounds.size.width/2-40, y: 30, width: 80, height: 50))
        btn.backgroundColor = UIColor.green.withAlphaComponent(0.5)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.setTitle("Start", for: .normal)
        btn.addTarget(self, action: #selector(move(sender:)), for: .touchUpInside)
        view.addSubview(btn)
    }
    @objc func move(sender: UIButton)
    {
        moveQueen()
        sender.setTitle("Running", for: UIControlState.normal)
        sender.setTitleColor(UIColor.red, for: UIControlState.normal)
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
    
    //Vòng lặp animation
    var currentIndexQueen = 0
    var rowSolution = 0
    var colSolution = 0
    var currentSolition = [Step]()
    func removeAllPieces()
    {
        self.pieceSets.first?.removeAllPieceControllers()
    }
    func removeBacktrackedPieces(backtrackStep: Step)
    {
        if(self.colSolution > 0)
        {
            self.pieceSets.first?.removeBacktrackedPieceControllers(backtrack: backtrackStep)
        }
    }
    func loop()
    {
        print("-----------\(self.rowSolution)")
        removeAllPieces()
        currentSolition = self.stepSolutions[self.rowSolution]
        animation()
    }
    
    func animation()
    {
        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: 1, animations: {
            print(self.currentSolition[self.colSolution])
            //Nếu bước đi mà là backtrack thì sẽ xoá các dòng và quay lại root của piece hiện tại
            if(self.currentSolition[self.colSolution].backtrack > 0)
            {
                self.removeBacktrackedPieces(backtrackStep: self.currentSolition[self.colSolution])
            }
            else
            {
                //Nếu vị trí đúng thì add piece
                if(self.currentSolition[self.colSolution].isTrue == true)
                {
                    self.pieceSets.first?.addnewQueenAt(position: Position(row: self.currentSolition[self.colSolution].position.row-1, col: self.currentSolition[self.colSolution].position.col-1), isTrue: true)
                }
                else
                {
                    //ngược lại add dấu X
                    self.pieceSets.first?.addnewQueenAt(position: Position(row: self.currentSolition[self.colSolution].position.row-1, col: self.currentSolition[self.colSolution].position.col-1), isTrue: false)
                }
            }
        }) { (finished) in
            //Kiểm tra đâu là bước đúng
            if(self.currentSolition[self.colSolution].position.row == self.rowTotal && self.currentSolition[self.colSolution].isTrue == true){
                self.dem = self.dem + 1
                self.screenShotMethod(name: String(self.dem))
                print("SolutionFind:\(self.dem)")
            }
            
            //Khi kết thúc animation thì tăng col lên 1
            self.colSolution = self.colSolution + 1
            print("RowSolution: \(self.rowSolution)")
            print("col: \(self.colSolution)")
            
            //Nếu col là dòng cuối cùng của solution đó thì tăng row lên 1
            if (self.colSolution == self.currentSolition.count)
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
    func screenShotMethod(name: String) {
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIImagePNGRepresentation(UIGraphicsGetImageFromCurrentImageContext()!)
        UIGraphicsEndImageContext()
        let path = URL(fileURLWithPath: "/Users/nguyenvantu/Desktop/Solutions/\(name).png")
        try! screenshot?.write(to: path)
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
        
        nQueens = EightQueen(row: self.rowTotal, col: self.rowTotal)
        self.stepSolutions = nQueens.stepSolutions
        self.pieceSets = [PieceSet]()
        
        let whitePieceSet = PieceSet(color: .White,
                                     rowTotal: rowTotal,
                                     colTotal: colTotal,
                                     width: width)
        whitePieceSet.delegate = self
        //        whitePieceSet.addPieces()
        
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
    func didRemovePieceController(pieceView: PieceView)
    {
        pieceView.removeFromSuperview()
    }
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
