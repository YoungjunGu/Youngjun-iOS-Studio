## Drawing App

아이폰 xs 에서도 그림그리기/ 메모가 가능한지 간단하게 테스트


### Function
> draw: 사용자의 그림 입력을 받는 함수

```

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
```
> touchesMoved: 

```
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
```
