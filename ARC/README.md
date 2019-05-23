# ARC (Automatic Reference Counting)

[Referece Counting](https://github.com/gaki2745/Youngjun-iOS-Studio/blob/master/ReferenceCount/README.md)에서 Swift에서는 앱의 메모리 사용을 관리하기 위해 ARC를 사용한다.  
자동으로 참조 횟수를 관리하기 때문에 개발자는 메모리 관리에 신경 쓸 필요가 없고 ARC가 **더이상 사용하지 않는 인스턴스를 메모리에서 해지**한다.  
  
하지만 ARC에서 메모리 관리를 위해 코드의 특정 부분에 대한 관계에 대한 정보를 필요로 한다. 그리고 클래스 타입의 인스턴스에만 적용(Heap영역에 클래스 객체가 생성이 되기 때문), 값 타입인 구조체 열거형 등에는 적용이 되지 않는다.  

</br>

## ARC의 동작  

ARC는 인스턴스가 그 어떤 참조가 **없을**경우에만 메모리에서 해지 하여 다른 용도로 쓰기 위해 메모리 공간을 마련한다.  
만약 ARC에 의해 해지가 된 인스턴스의 프로퍼티등을 접근한다면 앱은 **크래시**가 발생하게 되고 이는 앱에 심각한 위험을 초례한다.  
이처럼 ARC의 경우 인스턴스의 모든 프로퍼티,상수 또는 변수가 그 인스턴스에 대한 **참조를 갖고있는지 추적**하게된다. 그래서 참조가 있을 경우 ARC는 그 인스턴스를 메모리에서 해지하지 않는다.  

</br>

## ARC의 사용

### 단일 클래스의 ARC

하나의 클래스 내부에 다른클래스 인스턴스를 프로퍼티로 갖지 않는 아래와 같은 경우

```swift
class Unit {
	let name: String
	init(name: String) {
    	self.name = name
        print("\(name)이 initializing 되었습니다.")
    }
    deinit {
    	print("\(name)이 deinitializing 되었습니다.")
    }
       
}

var bionic: Unit?
var marine: Unit?
var medic: Unit?

//Unit 클래스 인스턴스 생성 bionic 변수가 참조
bionic = Unit(name: "Bionic")

// marine과 medic 변수가 bionic변수를 참조 (즉 하나의 Unit 클래스 인스턴스 참조)
// 현재 상황에서 Reference Counting = 3이다.
marine = bionic
medic = bionic
```

Unit 클래스의 인스턴스가 생성이 되고 marine 과 medic 변수가 bionic변수를 참조하면서 Unit 클래스의 Referecne Counting의 수는 3이 되고 이를 메모리에서 해제할려면 ARC는 Reference Counting 값이 0이되는 것을 항상 추적해야한다.  
  
```swift
bionic = nil
medic = nil
```  

이 경우 아직 marine 변수가 참조하고 있기 때문에 RC(Reference Counting) 의 값은 1이고  

```swift
marine = nil
// 출력:marine 이 deinitializing 되었습니다.
``` 
위처럼 RC 값이 결국 0 이 되고 ARC는 Unit 클래스 인스턴스를 메모리에서 해제한다. 

</br>

### 클래스 인스턴스간 Strong Reference Cycle (강한참조순환)  

```swift
class Unit {
    let name: String
    
    init(name: String) {
        self.name = name
        print("\(name) 이 initializing 되었습니다.")
    }
    var tribe: Tribe?
    deinit {
        print("\(name) 이 deinitializeing 되었습니다.  ")
    }
}

class Tribe {
    // 종족
    let name: String
    
    init(name: String) {
        self.name = name
        print("\(name) 이 initializing 되었습니다.")
    }
    var unit: Unit?
    deinit {
        print("\(name) 이 deinitializeing 되었습니다.  ")
    }
}
```

Unit 클래스와 Tribe(종족) 클래스가 서로의 클래스 인스턴스를 프로퍼티로 가지고 있는 상황이다.  

```swift
var terran: Tribe?
var marine: Unit?
        
terran = Tribe(name: "Terran")
marine = Unit(name: "Marine")
```  
<img width="806" alt="image" src="https://user-images.githubusercontent.com/33486820/58227225-eee99d80-7d64-11e9-8ca0-368889719dff.png">  

각각의 변수는 Class Instance를 참조하고 있고 이때 각 클래스의 RC값이 하나씩 증가한다.  
그럼 이때 nil 값이 었던 내부의 클래스 인스턴스를 서로 참조를 한다.  


```swift
terran?.unit = marine
marine?.tribe = terran
```  

<img width="782" alt="image" src="https://user-images.githubusercontent.com/33486820/58227330-5a336f80-7d65-11e9-9cac-01f60efa2d9f.png">  

기존의 RC 값이 각각 1이었다가 인스턴스 내부의 다른 클래스의 인스턴스를 참조하는 변수를 갖기 때문에 RC값은 2 가된다.  
그리고 `marine`과 `terran`변수의 참조를 nil을 대입하여 끊게되면  

```s
terran = nil
marine = nil
```  

<img width="798" alt="image" src="https://user-images.githubusercontent.com/33486820/58227442-d0d06d00-7d65-11e9-9bed-04236c74c277.png">  

위의 그림에서 볼수 있듯이 기존의 strong 하게 참조하던 `marine` 과 `terran` 변수의 참조는 해제가되어 RC의 값이 1씩 감소가 되었다. 하지만 개발자가 생각하기에 메모리에 두 클래스의 인스턴스는 해제되었다고 생각하겠지만 클래스내부에에서 서로의 클래스 인스턴스를 마찬가지로 강하게 참조하고 있기 때문에 RC값이 1 로 유지가 되고 ARC는 클래스인스턴스가 아직 유효하다고판단, **해제를 하지 않아 메모리에 누수가 발생한다.**  

</br>

### Strong Referecne Cycle Solution  







 





