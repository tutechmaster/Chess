//
//  PieceSet.swift
//  Chess
//
//  Created by Tuuu on 3/8/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation
import UIKit

class PieceSet
{
    var delegate: BoardViewDelegate!
    var pieceOrder = [PieceType]()
    var pieces = [Piece]()
    var color: PieceColor!
    var rowTotal: Int!
    var colTotal: Int!
    var width: CGFloat!
    
    
    init(color: PieceColor, rowTotal: Int, colTotal: Int, width: CGFloat) {
        pieceOrder.append(contentsOf: [.Rook, .Knight, .Bishop, .Queen, .King, .Bishop, .Knight, .Rook])
        self.color = color
        self.rowTotal = rowTotal
        self.colTotal = colTotal
        self.width = width
    }
    func addPieces()
    {
        addPieces(color: color, rowTotal: rowTotal, colTotal: colTotal, width: width)
        self.delegate?.didFinishInitPieceSet(pieces:self.pieces)
    }
    func addPieces(color: PieceColor, rowTotal: Int, colTotal: Int, width: CGFloat)
    {
        switch color {
        case .Black:
            let startCoordinates = Position(row: 0, col: 0)
            let endCoordinates = Position(row: 1, col: colTotal-1)
            self.addPiecesWith(startCoordinates: startCoordinates,
                               endCoordinates: endCoordinates,
                               color: color, width: width)
            break
        default:
            let startCoordinates = Position(row: rowTotal - 1, col: 0)
            let endCoordinates = Position(row: rowTotal - 2, col: colTotal - 1)
            self.addPiecesWith(startCoordinates: startCoordinates,
                               endCoordinates: endCoordinates,
                               color: color, width: width)
            break
        }
        
    }
    func addPiecesWith(startCoordinates: Position, endCoordinates: Position, color: PieceColor, width: CGFloat)
    {
        var isFirst = true // when isFirst == false, we just add pawns to the board
        var startRow = 0, endRow = 0
        let startCol = startCoordinates.col!
        let endCol = endCoordinates.col!
        startRow = startCoordinates.row
        endRow = endCoordinates.row
        let stepUp = startRow > endRow ? -1 : 1
        
        for row in stride(from: startRow, through: endRow, by: stepUp) {
            for col in startCol...endCol {
                let position = Position(row: row, col: col)
                let cellInfo = CellInfo(margin: 0, squareWidth: width)
                let currentPiece: Piece!
                if(isFirst == false)
                {
                    currentPiece = Pawn(pieceColor: color, at: position, cellInfo: cellInfo)
                    
                }
                else
                {
                    currentPiece = getPieceAt(type: self.pieceOrder[col] , color: color, at: position, cellInfo: cellInfo)
                }
                self.pieces.append(currentPiece)
            }
            isFirst = false
        }
    }
    func getPieceAt(type: PieceType, color: PieceColor, at position: Position, cellInfo: CellInfo) -> Piece
    {
        let currentPiece: Piece!
        switch type {
        case .King:
            currentPiece = King(pieceColor: color, at: position, cellInfo: cellInfo)
            break
        case .Queen:
            currentPiece = Queen(pieceColor: color, at: position, cellInfo: cellInfo)
            break
        case .Rook:
            currentPiece = Rook(pieceColor: color, at: position, cellInfo: cellInfo)
            break
        case .Bishop:
            currentPiece = Bishop(pieceColor: color, at: position, cellInfo: cellInfo)
            break
        case .Knight:
            currentPiece = Knight(pieceColor: color, at: position, cellInfo: cellInfo)
            break
        default:
            currentPiece = Pawn(pieceColor: color, at: position, cellInfo: cellInfo)
            break
        }
        return currentPiece
    }
}
