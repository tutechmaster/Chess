//
//  Piece.swift
//  Chess
//
//  Created by Tuuu on 3/8/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation
import UIKit
class Piece: UIImageView
{
    var pieceColor: PieceColor!
    var placeAt: Position!
    var moved: Bool!
    var type: PieceType!
    var cellInfo: CellInfo!
    init(pieceColor: PieceColor, at position: Position, cellInfo: CellInfo, type: PieceType)
    {
        super.init(image: UIImage())
        self.image = self.initImage(type: type, pieceColor: pieceColor)
        self.pieceColor = pieceColor
        self.type = type
        self.placeAt = position
        self.cellInfo = cellInfo
        self.isUserInteractionEnabled = true
        self.frame = CGRect(x: cellInfo.margin + CGFloat(CGFloat(position.col)*cellInfo.squareWidth), y: cellInfo.margin + CGFloat(CGFloat(position.row)*cellInfo.squareWidth), width: cellInfo.squareWidth, height: cellInfo.squareWidth)
        addGesture()
    }
    func initImage(type: PieceType, pieceColor: PieceColor) -> UIImage
    {
        return UIImage(named: "\(pieceColor.rawValue)\(type.rawValue)")!
    }
    override init(image: UIImage?) {
        super.init(image: image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func validMoves(startPosition: Position, endPosition: Position) -> Bool
    {
        return false
    }
    func attackSquares()
    {
        
    }
    func captureFreeMoves()
    {
        
    }
    func toBeCaptured() -> Bool
    {
        return true
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
            let width = self.frame.size.width
            let height = self.frame.size.height
            if(destinationPosition == nil || validMoves(startPosition: placeAt, endPosition: destinationPosition!) == false)
            {
                self.frame = CGRect(origin: CGPoint(x: self.cellInfo.margin + CGFloat(CGFloat(placeAt.col)*width), y: cellInfo.margin + CGFloat(CGFloat(placeAt.row)*width)), size: CGSize(width: width, height: height))
            }
            else
            {
                self.frame = CGRect(origin: CGPoint(x: self.cellInfo.margin + CGFloat(CGFloat(destinationPosition!.col)*width), y: cellInfo.margin + CGFloat(CGFloat(destinationPosition!.row)*width)), size: CGSize(width: width, height: height))
                self.placeAt = destinationPosition
            }
        }
    }
    func calculateDestinationPosition(point: CGPoint) -> Position?
    {
        let col = Int(point.x/self.frame.width)
        let row = Int(point.y/self.frame.height)
        //need to check if users move out size of board
//        if (row < 0 || row > self.rowTotal-1 || col < 0 || col > self.colTotal-1)
//        {
//            return nil
//        }
        return Position(row: row, col: col)
    }
}
