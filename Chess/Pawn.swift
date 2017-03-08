//
//  Pawn.swift
//  Chess
//
//  Created by Tuuu on 3/8/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation
class Pawn: Piece
{
    var promoted: Bool!
    var promoteTo: Piece!
    var moveDirection: MoveDirection!
    override init() {
        super.init()
        self.type = PieceType.Pawn
    }
}
