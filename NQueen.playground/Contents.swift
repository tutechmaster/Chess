//: Playground - noun: a place where people can play

import UIKit

var trace = [Int]()

func nQueens(row: Int, col: Int)
{
    for checkCol in
}
func isSafePlace(newRow: Int, newCol: Int) -> Bool
{
    for checkRow in 1...newRow
    {
        if(trace[checkRow] == newCol ||
            abs(checkRow - newRow) == abs(newCol - trace[checkRow]))
        {
            return false
        }
    }
    return true
}

//
//  main.cpp
//  BacnewRowTracnewRow
//
//  Created by Nguyen Van Tu on 3/10/17.
//  Copyright © 2017 Nguyen Van Tu. All rights reserved.
//

#include <iostream>

#include <iostream>
using namespace std;

int x[10];
int main() {
    
    void nqueens(int , int );
    
    for(int i = 0 ; i<10 ;i++)
    {
        x[i] = -1;
    }
    nqueens(1,4);
    
    
    
    return 0;
}


void nqueens(int k,int n){
    
    bool place(int , int);
    
    for(int i = 1 ; i<=n ;i++){
        
        if(place(k,i)){
            
            x[k] = i;
            
            if (k==n) {
                
                cout<<x[1]<<x[2]<<x[3]<<x[4]<<endl;
                
            }else{
                nqueens(k+1,n);
            }
        }
        
    }
    
}
bool place(int newRow , int newCol){
    
    for(int checkRow = 1 ; checkRow < newRow;checkRow++){
        
        if(x[checkRow] == newCol){
            
            return false;
            
        }
        if((abs(x[checkRow]-newCol)== abs(checkRow-newRow)))
        {
            return false;
        }
        
    }
    return true;
    
}
