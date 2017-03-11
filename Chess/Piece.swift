//
//  Piece.swift
//  Chess
//
//  Created by Tuuu on 3/8/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation
protocol PieceModelDelegate {
    func didFinishMove(position: Position)
}

class Piece
{
    var root: Piece!
    var delegate: PieceModelDelegate!
    var pieceColor: PieceColor!
    var placeAt: Position!
    var moved: Bool!
    var type: PieceType!
    init(pieceColor: PieceColor, at position: Position, type: PieceType)
    {
        self.pieceColor = pieceColor
        self.type = type
        self.placeAt = position

    }
    func getCurrentPlace() ->  Position
    {
        return self.placeAt
    }

    func validMoves(destination: Position) -> Bool
    {
        return false
    }
    func moveTo(destination: Position)
    {
        self.placeAt = destination
        self.delegate?.didFinishMove(position: self.placeAt)
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
