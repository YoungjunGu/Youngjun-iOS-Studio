//
//  ViewController.swift
//  DrawingApp
//
//  Created by youngjun goo on 08/01/2019.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit

//캔버스 클래스 선언
class Canvass: UIView {
    
    
    //var line = [CGPoint]()
    
    var lines = [[CGPoint]]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    override func draw(_ rect: CGRect) {
        //사용자의 그림입력을 받기 위한 함수 draw
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        //색깔
        context.setStrokeColor(UIColor.blue.cgColor)
        //굵기
        context.setLineWidth(10)
        
        context.setLineCap(.butt)
        
        lines.forEach { (line) in
            // for in 구문을 이용하여  i p 표 값을 가져 오고 context에 선을 추가하는 구문
            for (i, p) in line.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
        }
        
        
        context.strokePath()
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
        lastLine.append(point)
        
        lines.append(lastLine)
        
        setNeedsDisplay()
    }
}

class ViewController: UIViewController {
    
    let canvass = Canvass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //SubView 추가
        view.addSubview(canvass)
        canvass.backgroundColor = .white
        canvass.frame = view.frame
    }
    
    
}

