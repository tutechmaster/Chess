//
//  King.swift
//  Chess
//
//  Created by Tuuu on 3/8/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation
import UIKit

class King: Piece
{
    init(pieceColor: PieceColor, at position: Position)
    {
        super.init(pieceColor: pieceColor, at: position, type: .King)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
