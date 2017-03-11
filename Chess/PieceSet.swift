//
//  PieceSet.swift
//  Chess
//
//  Created by Tuuu on 3/8/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation
import UIKit
protocol PieceSetDelegate {
    func didFinishInitPieceSet(pieceControllers: [PieceController])
    func didFinishAddNewPiece(pieceController: PieceController)
}
class PieceSet
{
    var delegate: PieceSetDelegate!
    var pieceOrder = [PieceType]()
    var pieceControllers = Array<PieceController>()
    var color: PieceColor!
    var rowTotal: Int!
    var colTotal: Int!
    var width: CGFloat!
    var rootPiece: Piece!
    
    init(color: PieceColor, rowTotal: Int, colTotal: Int, width: CGFloat) {
        pieceOrder.append(contentsOf: [.Rook, .Knight, .Bishop, .Queen, .King, .Bishop, .Knight, .Rook])
        self.color = color
        self.rowTotal = rowTotal
        self.colTotal = colTotal
        self.width = width
    }
    func getPieceAt(position: Position) -> Piece?
    {
        for pieceController in self.pieceControllers
        {
            if(pieceController.pieceModel.placeAt.row == position.row &&
                pieceController.pieceModel.placeAt.col == position.col)
            {
                return pieceController.pieceModel
            }
        }
        return nil
    }
    func getPieceViewAt(position: Position) -> PieceView?
    {
        for pieceController in self.pieceControllers
        {
            if(pieceController.pieceModel.placeAt.row == position.row &&
                pieceController.pieceModel.placeAt.col == position.col)
            {
                return pieceController.pieceView
            }
        }
        return nil
    }
    func getPieceControllerAt(position: Position) -> PieceController?
    {
        for pieceController in self.pieceControllers
        {
            if(pieceController.pieceModel.placeAt.row == position.row &&
                pieceController.pieceModel.placeAt.col == position.col)
            {
                return pieceController
            }
        }
        return nil
    }
    func addPieces()
    {
        addPieceQueen(color: color, rowTotal: rowTotal-1, colTotal: colTotal-1, width: width)
        self.delegate?.didFinishInitPieceSet(pieceControllers:self.pieceControllers)
    }
    func addPieces(color: PieceColor, rowTotal: Int, colTotal: Int, width: CGFloat)
    {
        switch color {
        case .White:
            let startCoordinates = Position(row: 0, col: 0)
            let endCoordinates = Position(row: 1, col: colTotal-1)
            self.addPiecesWith(startCoordinates: startCoordinates,
                               endCoordinates: endCoordinates,
                               color: color,
                               width: width)
            break
        default:
            let startCoordinates = Position(row: rowTotal - 1, col: 0)
            let endCoordinates = Position(row: rowTotal - 2, col: colTotal - 1)
            self.addPiecesWith(startCoordinates: startCoordinates,
                               endCoordinates: endCoordinates,
                               color: color,
                               width: width)
            break
        }
        
    }
    
    func setNotSafePlaceForRootPosition(pieceController: PieceController)
    {
        var piece = pieceController.pieceModel
        while true {
            self.getPieceViewAt(position: (Position(row: ((piece?.placeAt.row)!),
                                                    col: (piece?.placeAt.col)!)))?.image = UIImage(named: "NoneNone")
            if(piece?.root == nil || piece?.placeAt.col != self.colTotal-1)
            {
                return
            }
            piece = piece?.root
        }
    }
    func removeQueenAt(position: Position)
    {
        let currentPieceControllers = self.pieceControllers
        for pieceController in currentPieceControllers
        {
            if(pieceController.pieceModel!.placeAt == position)
            {
                setNotSafePlaceForRootPosition(pieceController: pieceController)
//                pieceController.pieceView.image = UIImage(named: "NoneNone")
//                self.addnewQueenAt(position: position, isTrue: false)
//                self.pieceControllers.remove(object: pieceController)
            }
        }
    }
    func addnewQueenAt(position: Position, isTrue: Bool)
    {
        let cellInfo = CellInfo(margin: 0, squareWidth: width)
        let currentPiece: Piece!
        if(isTrue == false)
        {
            currentPiece = Piece(pieceColor: .None, at: position, type: .None)
        }
        else
        {
            currentPiece = Queen(pieceColor: color, at: position)
        }
        currentPiece.root = self.rootPiece
        self.rootPiece = currentPiece
        let pieceController = PieceController(pieceModel: currentPiece, cellInfo: cellInfo)
        self.pieceControllers.append(pieceController)
        self.delegate?.didFinishAddNewPiece(pieceController: pieceController)
    }
    func addPieceQueen(color: PieceColor, rowTotal: Int, colTotal: Int, width: CGFloat){
        
        let startCoordinates = Position(row: 0, col: 0)
        let endCoordinates = Position(row: 1, col: colTotal)
        self.addPieceQueenWith(startCoordinates: startCoordinates,
                           endCoordinates: endCoordinates,
                           color: color,
                           width: width)
    }
    
    func addPieceQueenWith(startCoordinates: Position, endCoordinates: Position, color: PieceColor, width: CGFloat){
        var isFirst = true // when isFirst == false, we just add pawns to the board
        var startRow = 0, endRow = 0
        let startCol = startCoordinates.col!
        let endCol = endCoordinates.col!
        startRow = startCoordinates.row
        endRow = endCoordinates.row
        for col in startCol...endCol {
            let position = Position(row: 0, col: col)
            self.addnewQueenAt(position: position, isTrue: true)
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
                    currentPiece = Pawn(pieceColor: color, at: position)
                    
                }
                else
                {
                    currentPiece = createPieceWith(type: self.pieceOrder[col] , color: color, at: position)
                }
                let pieceController = PieceController(pieceModel: currentPiece, cellInfo: cellInfo)
                self.pieceControllers.append(pieceController)
            }
            isFirst = false
        }
    }
    func createPieceWith(type: PieceType, color: PieceColor, at position: Position) -> Piece
    {
        let currentPiece: Piece!
        switch type {
        case .King:
            currentPiece = King(pieceColor: color, at: position)
            break
        case .Queen:
            currentPiece = Queen(pieceColor: color, at: position)
            break
        case .Rook:
            currentPiece = Rook(pieceColor: color, at: position)
            break
        case .Bishop:
            currentPiece = Bishop(pieceColor: color, at: position)
            break
        case .Knight:
            currentPiece = Knight(pieceColor: color, at: position)
            break
        default:
            currentPiece = Pawn(pieceColor: color, at: position)
            break
        }
        return currentPiece
    }
    func movePieceAt(fromPosition: Position, toPosition: Position)
    {
        
    }
}
extension Array where Element: AnyObject {
    mutating func remove(object: Element) {
        if let index = index(where: { $0 === object }) {
            remove(at: index)
        }
    }
}
