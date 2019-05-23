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
<img width="812" alt="image" src="https://user-images.githubusercontent.com/33486820/58230464-599fd680-7d6f-11e9-8630-d243dc521353.png">  


각각의 변수는 Class Instance를 참조하고 있고 이때 각 클래스의 RC값이 하나씩 증가한다.  
그럼 이때 nil 값이 었던 내부의 클래스 인스턴스를 서로 참조를 한다.  


```swift
terran?.unit = marine
marine?.tribe = terran
```  

<img width="841" alt="image" src="https://user-images.githubusercontent.com/33486820/58231885-0c256880-7d73-11e9-999a-bb631ed3258f.png">  


기존의 RC 값이 각각 1이었다가 인스턴스 내부의 다른 클래스의 인스턴스를 참조하는 변수를 갖기 때문에 RC값은 2 가된다.  
그리고 `marine`과 `terran`변수의 참조를 nil을 대입하여 끊게되면  

```swift
terran = nil
marine = nil
```  

<img width="821" alt="image" src="https://user-images.githubusercontent.com/33486820/58231946-337c3580-7d73-11e9-840e-4bb0fb441706.png">  


위의 그림에서 볼수 있듯이 기존의 strong 하게 참조하던 `marine` 과 `terran` 변수의 참조는 해제가되어 RC의 값이 1씩 감소가 되었다. 하지만 개발자가 생각하기에 메모리에 두 클래스의 인스턴스는 해제되었다고 생각하겠지만 클래스내부에에서 서로의 클래스 인스턴스를 마찬가지로 강하게 참조하고 있기 때문에 RC값이 1 로 유지가 되고 ARC는 클래스인스턴스가 아직 유효하다고판단, **해제를 하지 않아 메모리에 누수가 발생한다.**  

</br>

### Strong Referecne Cycle Solution  

- weak reference: 약한 참조
- unowned reference: 미소유 참조  

##### Weak Reference(약한 참조)  

약한 참조로 weak를 붙여 선언하게 되면 참조하고 있는 것이 먼저 메모리에서 해제되기 때문에 ARC는 약한 참조로 선언된 참조 대상이 해지 되면 런타임에 자동으로 참조하고 있는 변수에 nil을 할당한다.  


> 참고  
	ARC에서 약한 참조에 nil을 할당하면 프로퍼티 옵저버는 실행되지 않는다.  
    
    
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
    // weak를 붙여 unit 변수는 약하게 Unit class Instance를 참조하고 있다. 
    weak var unit: Unit?
    deinit {
        print("\(name) 이 deinitializeing 되었습니다.  ")
    }
}
```  

Tribe 클래스에서 unit 변수를 weak으로 선언했다.  

<img width="836" alt="image" src="https://user-images.githubusercontent.com/33486820/58232012-66bec480-7d73-11e9-9151-35a6472f6a87.png">  


```swift
var terran: Tribe?
var marine: Unit?
        
terran = Tribe(name: "Terran")
marine = Unit(name: "Marine")
        
// 1.
terran?.unit = marine
// 2.
marine?.tribe = terran
        
// 3.
marine = nil
// 출력 : Marine 이 deinitializeing 되었습니다.  

// 4.
terran = nil 
// 출력 : Terran 이 deinitializeing 되었습니다.  
```  

이 경우 1. 에서 unit의 Unit 인스턴스를 **weak** 하게 참조 하고 있기 때문에 RC의 경우를 올리지 않는다. 단지 marine 변수가 참조하고 있어 RC의 값은 1을 가지게 된다.  
3. 에서 marine의 Unit 클래스 인스턴스 참조를 해제시키면 Unit 의경우 RC 값이 0 이기 때문에 ARC는 Unit 클래스 인스턴스를 메모리에서 완전히 해제시키고 Tribe 클래스를 강하게 참조하고 있던 Unit 클래스 인스턴스가 사라지게 되고  

<img width="950" alt="image" src="https://user-images.githubusercontent.com/33486820/58232259-1431d800-7d74-11e9-879b-7308c76821cd.png">  

비로서 Tribe 의 RC 값은 1 이되고 4. 를 수행할 시 Tribe 클래스도 ARC에 의해`deinit` 이 수행 될 수 있는 것이다.  

<img width="853" alt="image" src="https://user-images.githubusercontent.com/33486820/58232712-37a95280-7d75-11e9-8743-7230f4a4a8b1.png">  


> 참고  
	Java 처럼 가비지 콜렉션을 사용하는 시스템에서 weak pointer를 단순한 시스템 캐싱 목적으로 사용하기도 한다. 메모리 소모가 많아지면 가비지 콜렉터를 실행해서 Strong 참조가 없는 객체를 메모리에서 해제하는 식으로 동작하기 때문이다. 하지만 ARC의 경우 가비지 콜렉터와 다르게 참조 횟수가 0이 되는 즉시 해당 인스턴스를 제거하기 때문에 약한 참조를 이런 목적으로 사용할 수 없다.  
    
> 결론 : weak 선언 시 RC 값 증가 시키지 않고 ARC는 RC가 0 인 클래스 인스턴스를 메모리 해지한다.  

</br>

#### Unowned References(미소유 참조)  

Weak Reference와 다르게 참조 대상이 되는 인스턴스가 현재 참조하고 있는 것과 같은 생애주기(lifetime)를 갖거나 더 긴 생애 주기(longer lifetime)을 갖기 때문에 항상 참조에 그 값이 있다고 생각한다. 그래서 **ARC는 미소유 참조에는 절대 nil을 할당하지 않는다 즉, 옵셔널 타입을 사용하지 않는다.**  

> 중요  
	미소유 참조는 참조 대상 인스턴스가 항상 존재한다고 생각하기 때문에 만약 미소유 참조로 선언된 인스턴스가 해제됐는데 접근하게 되면 런타임 에러가 발생한다.  
    

```swift
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}
```  

두 클래스 Customer 와 CreditCard 는 서로의 클래스 인스턴스를 참조하고 있다.  
이때 customer는 미소유 참조 `unowned`으로 선언한다.  
이유는 **고객과 신용카드를 비교해 봤을때 신용카드는 없더라도 사용자는 남아있을 것이기 때문**이다.  다시 말하면 신용카드가 없더라도 사용자는 존재하기 때문이다.  
그렇기 때문에 CreditCard의 customer를 unowned로 선언한다.  
  
그리고 Customer 변수를 생성하고 프로퍼티 값을 설정한다.  

```swift
var john: Customer?

john = Customer(name: "John Appleseed")
john!.card = CreditCard(number:1234_5678_9012_3456,customer:john!)
```  

<img width="936" alt="image" src="https://user-images.githubusercontent.com/33486820/58236160-3bd96e00-7d7d-11e9-88c9-6dc83fb6606b.png">

jonh 변수가 Customer 인스턴스를 참조하고 있고 CreditCard 인스턴스도 Customer 인스턴스를 참조하고 있지만 **Unowned 참조**를 하고 있기 때문에 Customer 클래스의 RC의 값은 1이된다.  
  
이 상황에서 john 변수의 Customer 인스턴스 참조를 끊으면 다음과 같이 된다.  

<img width="971" alt="image" src="https://user-images.githubusercontent.com/33486820/58236306-983c8d80-7d7d-11e9-96e9-2f59fe9a72d1.png">

```swift
john = nil
// Prints "John Appleseed is being deinitialized"
// Prints "Card #1234567890123456 is being deinitialized"
```  

그렇게 되면 Customer클래스의 RC의 값은 john변수에 의해 강하게 참조 되고 있던것이 끊어져 1이되고 ARC에 의해 Customer 인스턴스가 메모리 해제되고 마찬가지로 CreditCard 인스턴스 또한 메모리에서 해제된다.  

> 참고  
	위 예제는 안전하게 미소유 참조를 사용하는 방법의 예이다. 반면 Swift에서는 성능문제를 위해 런타임에 안전성 확인을 하지 않고 사용하는 unsafe 미소유 참조도 제공한다.   
    
 
</br>
<hr>

## Reference  

- https://jusung.gitbook.io/the-swift-language-guide/untitled-19
- https://medium.com/@jang.wangsu/ios-swift-rc-arc-와-mrc-란-그리고-strong-weak-unowned-는-간단하게-적어봤습니다-988a293c04ac
- http://monibu1548.github.io/2018/05/03/iboutlet-strong-weak/
    
    










        










 





