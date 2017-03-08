//
//  Player.swift
//  Chess
//
//  Created by Tuuu on 3/8/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation
protocol PlayerEngine {
    func makeMove()
}

class Player
{
    var pieceColor: PieceColor!
    var engine: PlayerEngine!
}
