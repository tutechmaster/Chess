//
//  EightQueen.swift
//  Chess
//
//  Created by Loc Tran on 3/10/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation
import UIKit

class EightQueen {
    
    var trace = [Int]()
    var queens = [[Position]]()
    var index = 0
    init(row: Int, col: Int) {
        trace = [Int](repeating: 0, count: row+1)
        nQueens(row: 1, col: col)
    }
    func output(){
        
        
        var currentPositions = [Position]()
        for i in 1..<trace.count
        {
            let queen = Position(row: i - 1, col: trace[i] - 1 )
            currentPositions.append(queen)
            
        }
        queens.append(currentPositions)
        
    }
    func nQueens(row: Int, col: Int)
        
    {
        
        for checkCol in 1...col
        {
            if(isSafePlace(newRow: row, newCol: checkCol))
            {
                trace[row] = checkCol
                if(row == col)
                {
                    self.output()
                }
                else
                {
                    nQueens(row: row+1, col: col)
                }
            }
        }
        
    }
    
    func isSafePlace(newRow: Int, newCol: Int) -> Bool
        
    {
        for checkRow in 1...newRow
            
        {
            if(trace[checkRow] == newCol || abs(checkRow - newRow) == abs(trace[checkRow]-newCol))
                
            {
                return false
            }
        }
        
        return true
        
    }

    
}
