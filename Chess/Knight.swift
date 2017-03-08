//
//  Knight.swift
//  Chess
//
//  Created by Tuuu on 3/8/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation
import UIKit

class Knight: Piece
{
    init(pieceColor: PieceColor, at position: Position, cellInfo: CellInfo)
    {
        super.init(pieceColor: pieceColor, at: position, cellInfo: cellInfo, type: .Knight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
