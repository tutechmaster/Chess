//
//  Pawn.swift
//  Chess
//
//  Created by Tuuu on 3/8/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation
import UIKit

class Pawn: Piece
{
    //lần đầu đi 2
    //đi thẳng 1
    //ăn chéo
    var promoted = false
    var promoteTo: Piece!
    var moveDirection: MoveDirection!
    var isFristMove = true
    var toOccupiedSquare = false
    
    init(pieceColor: PieceColor, at position: Position, cellInfo: CellInfo)
    {
        super.init(pieceColor: pieceColor, at: position, cellInfo: cellInfo, type: .Pawn)
        self.moveDirection = pieceColor == .Black ? .Up:.Down
    }
    override func validMoves(startPosition: Position, endPosition: Position) -> Bool{
        var checkValidMovesUp = true
        if self.moveDirection == .Up {
            checkValidMovesUp = self.validMovesUp(startPosition: startPosition, endPosition: endPosition)
        }
        else
        {
            checkValidMovesUp = self.validMovesDown(startPosition: startPosition, endPosition: endPosition)
        }
        
        if(checkValidMovesUp == false)
        {
            return false
        }
        else
        {
            if(startPosition.col == endPosition.col)
            {
                //vertical
                if(toOccupiedSquare == false)
                {
                    return true
                }
                else
                {
                    return false
                }
            }
            else
            {
                //diagonal
                if(toOccupiedSquare == true)
                {
                    return true
                }
                else
                {
                    return false
                }
            }
        }
    }
    func validMovesUp(startPosition: Position, endPosition: Position) -> Bool
    {
        //nếu di chuyển hơn 2 ô thì false
        if(startPosition.row < endPosition.row ||
            startPosition.row - endPosition.row > 1 ||
            startPosition.col - endPosition.col > 1)
        {
            return false
        }
        return true
        
    }
    func validMovesDown(startPosition: Position, endPosition: Position) -> Bool
    {
        //nếu di chuyển hơn 2 ô thì false
        if(startPosition.row > endPosition.row ||
            startPosition.row - endPosition.row < -1  ||
            startPosition.col - endPosition.col < -1)
        {
            return false
        }
        return true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    
}
