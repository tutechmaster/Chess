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
    var rootPosition:Position!
    var position:Position!
    var isTrue: Bool
    var isBackTrack: Bool
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
        nQueens(row: 1, col: col, rootCol: 0)
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
            if(step.position.col == self.totalCol)
            {
                var backtrackedStep = step
                if(step.isTrue == false)
                {
                    backtrackedStep.isBackTrack = true
                    curretSolution.append(backtrackedStep)
                }
                if(step.rootPosition.col == self.totalCol)
                {
                    if(step.isTrue == false || (step.isTrue == true && step.position.row == self.totalCol))
                    {
                        stepSolutions.append(curretSolution)
                        curretSolution = [Step]()
                    }
                    
                    //                curretSolution = self.removeStepsAt(row: step.row, solution: curretSolution)
                }
            }
            

        }
    }
//    func removeStepsAt(row: Int, solution: [Step]) -> [Step]
//    {
//        var currentSolution = solution
//
//        for step in solution
//        {
//            if(step.row == row)
//            {
//                currentSolution.removeObject(object: step)
//            }
//        }
//        return currentSolution
//    }
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
    func nQueens(row: Int, col: Int, rootCol: Int)
    {
        for checkCol in 1...col
        {
            if(isSafePlace(newRow: row, newCol: checkCol, rootPosition: Position(row: row-1, col: rootCol)))
            {
                trace[row] = checkCol
                if(row == col)
                {
//                    self.output()
                }
                else
                {
                    nQueens(row: row+1, col: col, rootCol: checkCol)
                }
            }
        }
//        self.output()
    }
    
    func isSafePlace(newRow: Int, newCol: Int, rootPosition: Position) -> Bool
    {
        var step = Step(rootPosition: rootPosition, position: Position(row: newRow, col: newCol), isTrue: true, isBackTrack: false)
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
//extension Step: Equatable
//{
//    /// Returns a Boolean value indicating whether two values are equal.
//    ///
//    /// Equality is the inverse of inequality. For any values `a` and `b`,
//    /// `a == b` implies that `a != b` is `false`.
//    ///
//    /// - Parameters:
//    ///   - lhs: A value to compare.
//    ///   - rhs: Another value to compare.
//    public static func ==(lhs: Step, rhs: Step) -> Bool {
//        if (lhs.row == rhs.row && lhs.col == rhs.col && lhs.isTrue == rhs.isTrue)
//        {
//            return true
//        }
//        return false
//    }
//}
//extension Array where Element: Equatable
//{
//    mutating func removeObject(object: Element) {
//        
//        if let index = index(of: object) {
//            remove(at: index)
//        }
//    }
//}
