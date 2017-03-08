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
    init(pieceColor: PieceColor, at position: Coordinates, cellInfo: CellInfo)
    {
        let image: UIImage!
        switch pieceColor {
        case .Black:
            image = UIImage(named: "whitePawn")
            break
        default:
            image = UIImage(named: "whitePawn")
            break
        }
        super.init(pieceColor: pieceColor, at: position, cellInfo: cellInfo, image: image)
        self.type = PieceType.Pawn
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
