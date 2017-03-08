//
//  Bishop.swift
//  Chess
//
//  Created by Tuuu on 3/8/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation
import UIKit

class Bishop: Piece
{
    init(pieceColor: PieceColor, at position: Position, cellInfo: CellInfo)
    {
        let image: UIImage!
        switch pieceColor {
        case .Black:
            image = UIImage(named: "blackBishop")
            break
        default:
            image = UIImage(named: "whiteBishop")
            break
        }
        super.init(pieceColor: pieceColor, at: position, cellInfo: cellInfo, image: image)
        self.type = PieceType.Bishop
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
