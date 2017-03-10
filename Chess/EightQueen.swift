//
//  EightQueen.swift
//  Chess
//
//  Created by Loc Tran on 3/10/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation
import UIKit
struct Step {
    var row:Int
    var col:Int
    var isTrue: Bool
}
class EightQueen {
    var steps = [Step]()
    var stepSolutions = [[Step]]()
    var trace = [Int]()
    var queens = [[Position]]()
    var index = 0
    var totalCol = 0
    init(row: Int, col: Int) {
        self.totalCol = col
        trace = [Int](repeating: 0, count: row+1)
        nQueens(row: 1, col: col)
        detectSteps()
//        loop()
        print("Done")
    }
    func detectSteps()
    {
        var curretSolution = [Step]()
        for step in self.steps
        {
//            print(step.col)
            curretSolution.append(step)
            if((step.col == self.totalCol && step.isTrue == false) || (step.row == self.totalCol))
            {
                stepSolutions.append(curretSolution)
                curretSolution = [Step]()
            }

        }
    }
    func output(){
        stepSolutions.append(steps)
        steps = [Step]()
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
//                    self.output()
                }
                else
                {
                    nQueens(row: row+1, col: col)
                }
            }
        }
//        self.output()
    }
    
    func isSafePlace(newRow: Int, newCol: Int) -> Bool
    {
        var step = Step(row: newRow, col: newCol, isTrue: true)
        for checkRow in 1..<newRow
        {
            if(trace[checkRow] == newCol || abs(checkRow - newRow) == abs(trace[checkRow]-newCol))
            {
                step.isTrue = false
                self.steps.append(step)
                return false
            }
        }
        self.steps.append(step)
        return true
        
    }
    var rowSolution = 0
    var colSolution = 0
    var currentSolition = [Step]()
    func loop()
    {
        currentSolition = self.stepSolutions[self.rowSolution]
        animation()
    }
    func animation()
    {
        UIView.animate(withDuration: 1.0, animations: {
            print(self.currentSolition[self.colSolution])
        }) { (finished) in
            self.colSolution = self.colSolution + 1
            if(self.rowSolution == self.stepSolutions.count-1)
            {
                return
            }
            if(self.colSolution == self.currentSolition.count-1)
            {
                self.colSolution = 0
                self.rowSolution = self.rowSolution + 1
                self.loop()
                return
            }
            self.animation()
        }
    }
    
}
