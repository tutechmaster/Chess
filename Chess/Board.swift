//
//  Board.swift
//  Chess
//
//  Created by Tuuu on 3/8/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation
import UIKit

protocol BoardViewDelegate {
    func didFinishInitPieceSet(pieces: [Piece])
}

class Board: UIView
{
    var squares:[[Square]]! //1-->64
    var pieceSets:[PieceSet]! // 1-->2
    var pieceSetOnTop: PieceColor!
    init(frame: CGRect, rowTotal: Int, colTotal: Int) {
        super.init(frame: frame)
        self.pieceSets = [PieceSet]()
        self.squares = [[Square]]()
        self.drawBoard(rowTotal: rowTotal, colTotal: colTotal)
        self.addPieceSet(rowTotal: rowTotal, colTotal: colTotal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addPieceSet(rowTotal: Int, colTotal: Int)
    {
        let width = self.frame.width/CGFloat(rowTotal)
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
    private func drawBoard(rowTotal: Int, colTotal: Int){
        var cellColor = UIColor()
        let cellSize = self.frame.width/CGFloat(rowTotal)
        for indexRow in 0..<rowTotal
        {
            for indexCol in 0..<colTotal
            {
                if ((indexCol + indexRow) % 2 == 0){
                    cellColor = UIColor.gray
                }else{
                    cellColor = UIColor.white
                }
                let cell = Square(frame: CGRect(x: CGFloat(indexRow) * cellSize,
                                                y: CGFloat(indexCol) * cellSize,
                                                width: cellSize, height: cellSize),
                                                color: cellColor)
                self.addSubview(cell)
                print("\(indexRow), \(indexCol)")
                
            }
        }
    }
    func create()
    {
        
    }
}
extension Board:
    BoardViewDelegate
{
    func didFinishInitPieceSet(pieces: [Piece]) {
        for piece in pieces
        {
            self.addSubview(piece)
        }
    }
}
