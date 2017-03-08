//
//  Piece.swift
//  Chess
//
//  Created by Tuuu on 3/8/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation
import UIKit

class Piece: UIImageView
{
    var pieceColor: PieceColor!
    var placeAt: Position!
    var moved: Bool!
    var type: PieceType!
    init(pieceColor: PieceColor, at position: Position, cellInfo: CellInfo, image: UIImage)
    {
        super.init(image: image)
        self.pieceColor = pieceColor
        self.placeAt = position
        self.frame = CGRect(x: cellInfo.margin + CGFloat(CGFloat(position.col)*cellInfo.squareWidth), y: cellInfo.margin + CGFloat(CGFloat(position.row)*cellInfo.squareWidth), width: cellInfo.squareWidth, height: cellInfo.squareWidth)
    }
    override init(image: UIImage?) {
        super.init(image: image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
