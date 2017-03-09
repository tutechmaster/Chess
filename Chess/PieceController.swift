//
//  PieceController.swift
//  Chess
//
//  Created by Tuuu on 3/9/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation

class PieceController {
    var pieceModel: Piece!
    var pieceView: PieceView!
    
    init(pieceModel: Piece, cellInfo: CellInfo) {
        self.pieceModel = pieceModel
        self.pieceModel.delegate = self
        
        self.pieceView = PieceView(pieceColor: pieceModel.pieceColor,
                                   at: pieceModel.placeAt,
                                   type: pieceModel.type,
                                   cellInfo: cellInfo)
        self.pieceView.delegate = self
    }
}
extension PieceController: PieceModelDelegate
{
    
}
extension PieceController: PieceViewDelegate
{
    func validMoves(destination: Position) -> Bool {
        return self.pieceModel.validMoves(destination: destination)
    }
    func getCurrentPlace() -> Position {
        return self.pieceModel.getCurrentPlace()
    }
    func setCurrentPlace(place: Position) {
        self.pieceModel.setCurrentPlace(place: place)
    }
}
