//
//  Board.swift
//  Chess
//
//  Created by Tuuu on 3/8/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation
import UIKit


class Board: UIView
{
    var squares:[[Square]]! //1-->64
    var rowTotal: Int!
    var colTotal: Int!
    init(frame: CGRect, rowTotal: Int, colTotal: Int) {
        super.init(frame: frame)
        self.rowTotal = rowTotal
        self.colTotal = colTotal
        self.squares = [[Square]]()
        self.drawBoard(rowTotal: rowTotal, colTotal: colTotal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawBoard(rowTotal: Int, colTotal: Int){
        var cellColor = UIColor()
        let cellSize = self.frame.width/CGFloat(rowTotal)
        for indexRow in 0..<rowTotal
        {
            for indexCol in 0..<colTotal
            {
                if ((indexCol + indexRow) % 2 == 0){
                    cellColor = UIColor.gray
                }else{
                    cellColor = UIColor.white
                }
                let cell = Square(frame: CGRect(x: CGFloat(indexRow) * cellSize,
                                                y: CGFloat(indexCol) * cellSize,
                                                width: cellSize, height: cellSize),
                                                color: cellColor)
                self.addSubview(cell)
                print("\(indexRow), \(indexCol)")
                
            }
        }
    }
    func create()
    {
        
    }
}
