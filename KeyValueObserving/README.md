# Key Value Observing(KVO)

객체가 다른 객체의 특정 속성에 대한 **변경 사항을 알리는** 메커니즘을 제공한다.  
`willSet`과 `didSet`처럼 객체의 정의부에서 관찰하는 방법과 달리 KVO는 **정의부 바깥에서 관찰행위를 해주는 방법**이다.  
그렇기 때문에 조금더 유연한 구조를 설계할 수 있다.  

KVO의 경우 Objective-C에서 사용하던 방법을 Swift에 강제로 적용시킨 느낌이 없지 않아 있고 가독성 또한 떨어졌다. 무엇보다 `willSet`과 `didSet`을 사용하여 특정 프로퍼티의 값의 변화를 추적하는 것이 더 나은 방법이 될 수 도있기때문이다.  
하지만 Swift 4부터 `observe(_:options:changeHandler)` 메서드가 추가가 되어 **Observer 와 Action을 동시에 정의해줄수 있다.**  
또한 기존의 `addObserver(_:forKeyPath:options:context:)`메서드를 사용하여 KeyPath를 문자열로 입력하던 것과 다르게 프로퍼티로 접근이가능해졌다. 

</br>

### Observing할 관찰 객체 생성  

```swift
// Objective-C 런타임에서 구동이 되기 때문에 NSObject 상속해야한다.
// @objcMembers 키워드를 클래스 앞에 선언 하게 되면 dynamic 키워드 앞에 @obj 키워드를 생략 할 수 있다. 
@objcMembers class Time: NSObject {
    // 감지할 객체앞에 'dynamic' 키워드를 붙인다.
    dynamic var stopWatch: Date
    
    init(stopWatch: Date) {
        self.stopWatch = stopWatch
    }
}
```

- Objective-C 런타임에서 구동이 되기 때문에 `NSObject` 상속해야한다.
- `@objcMembers` 키워드를 클래스 앞에 선언 하게 되면 `dynamic` 키워드 앞에 `@obj` 생략이 가능하다  

</br>

### Time클래스를 관리할 Manager 클래스 생성  

```swift

class TimeManager {

    var time: Time
    // dateformmating 해주는 함수
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy:MM:dd HH:mm:ss"
        return dateFormatter
    }()
    
    var stopWatch: String {
        return dateFormatter.string(from: time.stopWatch)
    }
    
    init(_ time: Time) {
        self.time = time
    }
    
    func stopTheWatch() {
        time.stopWatch = Date()
    }
    
}
```

- Time 클래스 인스턴스를 하나 가지고 Time 인스턴스의 `stopWatch` `dynamic` 프로퍼티 값에 접근 하여 DateFormmatting을 하여 반환 하고 `stopTheWatch()`메서드를 통해 현재 시간으로 값을 변경하기도해준다.  

</br>

### 실제 변화를 감지  

```swift
var observations:[NSKeyValueObservation] = []
let timeManager = TimeManager(Time(stopWatch: Date()))
```

- `observe(_:options:changeHandler)`는 일종의 **관찰자를 반환**한다. 이렇게 변환된 관찰자는 **반드시 저장하고있어야한다.** 저장을 하지 않으면 코드가 수행이 되지 않는다.(`Result of call to 'observe(_:options:changeHandler:)' is unused` 의 경고와함께..)  

```swift
  func setUpObserver() {
        let dateObservation = timeManager.time.observe(\.stopWatch, options: [.new]) { (observed, changed) in
            print("Stop the Watch!! Current time is \(String(describing: changed.newValue))")
            if let newTime = changed.newValue {
                // timeManager.stopWatch 의 변수와 같지만 새롭게 변경되어 감지가된 newValue를 통해 Label의 값을 변경
                self.timeLabel.text = self.timeManager.dateFormatter.string(from: newTime)
            }
        }
        observations.append(dateObservation)
    }
```
- Observer(관찰자)와 Action(행위)를 정의해주는 메서드이다. `NSObject`를 상속한 클래스, 즉 Time 클래스의 인스턴스를 관찰하게되고 KeyPath를 `\.propery` 형식으로 관찰하고자 하는 프로퍼티에 **직접 접근**이 가능하다.  

- `observe(_:options:changeHandler)` 메서드의 `options` 은 관찰할 변화의 상태들을 넣어줄 수 있다.
	- `.new` : 값이 실제로 한번 갱신되었을 때부터 적용이된다.
    - `.initial` : 객체가 생성되는 시점에 바로 감지를 한다.  

쉽게 말해 `.inital`은  Time 객체를 생성하자마자 `setUpObserver()`함수가 호출이 되어 Label의 텍스트가 변경이 된다.  

<img width="1251" alt="image" src="https://user-images.githubusercontent.com/33486820/58341858-3289f780-7e8a-11e9-9b09-208678aedc2b.png">  


핸들러에서 **관찰이 된 값(observed)** 와 **변화가 감지된 값(changed)** 값의 경우 관찰이 된 시점에서 Label에 변화를 주고 싶다면 `[.initial, new]`로 option을 설정해주면 된다.  

> 참고  
	dynamic dispatch를 활성화 시켜 `dynamic` 이 붙은 프로퍼티의 주소를 찾아주는 작업에서(`observe(\.stopWatch)...`) 에서 클로저에서 Reference Cycle을 방지하기 위해 observed, changed 를 weak 속성을 붙여주는 것도 고려해보는 것이 좋다.  
    
    
```swift
func setUpObserver() {
        let dateObservation = timeManager.time.observe(\.stopWatch, options: [.initial, .new]) {[weak self] (observed, changed) in
            print("Stop the Watch!! Current time is \(String(describing: changed.newValue))")
            if let newTime = changed.newValue {
                // timeManager.stopWatch 의 변수와 같지만 새롭게 변경되어 감지가된 newValue를 통해 Label의 값을 변경
                self.timeLabel.text = self.timeManager.dateFormatter.string(from: newTime)
            }
        }
        observations.append(dateObservation)
    }
```    

</br>
<hr>

# Key Value Coding   

https://m.post.naver.com/viewer/postView.nhn?volumeNo=8970029&memberNo=37948224  


</br>
<hr>

## Reference  

- http://seorenn.blogspot.com/2017/07/swift-4-kvo.html
- https://developer.apple.com/documentation/swift/cocoa_design_patterns/using_key_value_observing_in_swift  
- https://baked-corn.tistory.com/126



