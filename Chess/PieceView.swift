//
//  PieceView.swift
//  Chess
//
//  Created by Tuuu on 3/9/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation
import UIKit
protocol PieceViewDelegate {
    func validMoves(destination: Position) -> Bool
    func getCurrentPlace() ->  Position
    func setCurrentPlace(place: Position)
}
class PieceView: UIImageView
{
    var delegate: PieceViewDelegate!
    var cellInfo: CellInfo!
    init(pieceColor: PieceColor, at position: Position, type: PieceType, cellInfo: CellInfo!)
    {
        super.init(image: UIImage())
        self.isUserInteractionEnabled = true
        let image = self.initImage(type: type, pieceColor: pieceColor)
        self.image = image
        self.cellInfo = cellInfo
        self.frame = CGRect(x: cellInfo.margin + CGFloat(CGFloat(position.col)*cellInfo.squareWidth), y: cellInfo.margin + CGFloat(CGFloat(position.row)*cellInfo.squareWidth), width: cellInfo.squareWidth, height: cellInfo.squareWidth)
        self.addGesture()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initImage(type: PieceType, pieceColor: PieceColor) -> UIImage
    {
        return UIImage(named: "\(pieceColor.rawValue)\(type.rawValue)")!
    }
    
    func calculateDestinationPosition(point: CGPoint) -> Position?
    {
        let col = Int(point.x/self.frame.width)
        let row = Int(point.y/self.frame.height)
        //kiểm tra người dùng kéo ra khỏi bàn cở, cần gọi piecemodel để xử lý.
        //        if (row < 0 || row > self.rowTotal-1 || col < 0 || col > self.colTotal-1)
        //        {
        //            return nil
        //        }
        return Position(row: row, col: col)
    }
    //MARK: PanGesture
    func addGesture()
    {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(actionPanGesture(_:)))
        self.addGestureRecognizer(panGesture)
    }
    func actionPanGesture(_ panGesture: UIPanGestureRecognizer)
    {
        if (panGesture.state == .began || panGesture.state == .changed)
        {
            let point = panGesture.location(in: self.superview)
            self.center = point;
        }
        if (panGesture.state == .ended)
        {
            let point = panGesture.location(in: self.superview)
            let destinationPosition = calculateDestinationPosition(point: point)
            
            
            //gọi đến validMoves bên model thông qua viewcontroller
            if(destinationPosition == nil || delegate.validMoves(destination: destinationPosition!) == false)
            {
                let placeAt = delegate.getCurrentPlace()
                self.moveTo(row: placeAt.row, col: placeAt.col)
            }
            else
            {
                self.moveTo(row: destinationPosition!.row, col: destinationPosition!.col)
                //cập nhật bên model
                delegate.setCurrentPlace(place: destinationPosition!)
            }
        }
    }
    func moveTo(row: Int, col: Int)
    {
        let width = self.frame.size.width
        let height = self.frame.size.height
        self.frame = CGRect(origin: CGPoint(x: self.cellInfo.margin + CGFloat(CGFloat(col)*width), y: cellInfo.margin + CGFloat(CGFloat(row)*width)), size: CGSize(width: width, height: height))
    }
}
