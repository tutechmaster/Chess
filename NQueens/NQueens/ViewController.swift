//
//  ViewController.swift
//  NQueens
//
//  Created by Tuuu on 3/10/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var trace = [Int]()
    let nQueens = 4
    override func viewDidLoad() {
        super.viewDidLoad()
        trace = [Int](repeating: 0, count: nQueens+1)
        nQueens(row: 1, col: 4)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func output()
    {
        for i in 1..<trace.count
        {
            print("row:\(i) col:\(trace[i])")
        }
        print("____________________")
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
        for checkRow in 1..<newRow
            
        {
            if(trace[checkRow] == newCol || abs(checkRow - newRow) == abs(trace[checkRow]-newCol))
                
            {
                return false
            }
        }
        
        return true
        
    }

}

