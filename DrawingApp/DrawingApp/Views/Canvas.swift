//
//  Canvas.swift
//  DrawingApp
//
//  Created by youngjun goo on 09/01/2019.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit

//캔버스 클래스 선언
class Canvas: UIView {
    
    fileprivate var strokeColor = UIColor.black
    fileprivate var strokeLineWidth: Float = 1
    
    //var line = [CGPoint]()
    var popLines = [Line]()
    var lines = [Line]()
    
    func setStrokeColor(color: UIColor) {
        self.strokeColor = color
    }
    
    func setStrokeLineWidth(width: Float) {
        self.strokeLineWidth = width
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(strokeLineWidth: strokeLineWidth, color: strokeColor, points: []))
    }
    
    override func draw(_ rect: CGRect) {
        //사용자의 그림입력을 받기 위한 함수 draw
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        context.setLineCap(.butt)
        
        lines.forEach { (line) in
            //색깔
            context.setStrokeColor(line.color.cgColor)
            //굵기
            context.setLineWidth(CGFloat(line.strokeLineWidth))
            // for in 구문을 이용하여  i p 표 값을 가져 오고 context에 선을 추가하는 구문
            for (i, p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
      
    }
    
    //UNDO
    //반드시
    func undo() {
        let popLine = lines.popLast()
        popLines.append(popLine!)
        setNeedsDisplay()
    }
    //REDO
    func redo() {
        if let popLine = popLines.popLast() {
            lines.append(popLine)
            setNeedsDisplay()
        } else {
            print("Nothing can redo!!")
        }
    }
    
    //CLEAR
    func clear() {
        lines.removeAll()
        popLines.removeAll()
        setNeedsDisplay()
    }
    
    //손가락의 움직임을 tracking
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //사용자의 터치를 감지하여 X, Y  좌표값으로 반환 한다.
        guard let point = touches.first?.location(in: nil) else {
            return
        }
        //마지막 라인 popLast()
        guard var lastLine = lines.popLast() else {
            return
        }
        lastLine.points.append(point)
        
        lines.append(lastLine)
        
        setNeedsDisplay()
    }
}
