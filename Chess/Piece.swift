//
//  Piece.swift
//  Chess
//
//  Created by Tuuu on 3/8/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation
import UIKit

class Piece
{
    var pieceColor: PieceColor!
    var placeAt: Square!
    var moved: Bool!
    var type: PieceType!
    func validMoves()
    {
        
    }
    func attackSquares()
    {
        
    }
    func captureFreeMoves()
    {
        
    }
    func toBeCaptured() -> Bool
    {
        return true
    }
}
