# 프로토콜(Protocol) 기본 / Pop (Protocol Oriented Programming)

> 기본을 충실하게!

## 프로토콜(Protocol) 이란?

- 작업에 필요한 메서드,프로퍼티 및 요구사항을 정의하는 일종의 **약속, 계약** 의 역할을 한다. 그후 프로토콜 클래스, 구조체, 열거형에서 채택(adoption)하여 이러한 요구 사항을 자세하게 실제 구현할 수 있다.


## 1. Property Requirements( 프로퍼티 요구사항)

### 프로토콜 내의 프로퍼티 선언 

> 프로토콜 프로퍼티 선언 시 

- 프로토콜은 프로퍼티가 **save** 인지 **operation** 인지 명시하지 않는다.
- 읽기 가능한지, 읽기/쓰기 모두 가능한지 명시해야한다 ( 'setter' always be with 'getter')
- 프로퍼티 요구사항은 항상 **var** 로 선언되어야한다.

### 상수(Constant), 변수(Variable) 저장 프로퍼티

```swift
protocol MajorInformed {
	var myMajor: String { get }
}

struct Student: MajorInformed {
	let myMajor: String
}

var gaki = Student(MyMajor: "CES")

gaki.myMajor = "Electric Engineering" // error 발생 
```

myMajor 프로퍼티가 let으로 선언되었기 때문에 값을 변경할 수 없다. var 로 선언 하게 되면 변경이 가능하다.


### 연산프로퍼티 gettable

값을 저장하고 리턴할 변수가 따로 필요하다

```swift
protocol MajorInformed {
	var myMajor: String { get }
}

struct Student: MajorInformed {
	var university: String
	var myMajor: String {
    		
     	return university
    }
}

var gaki = Student(university: "KNU")

gaki.myMajor = "Electric Engineering" // error 발생 
```

- myMajor의 프로퍼티값은 읽기 전용이기 때문에 달느 값을 넣어 줄 수 없다.
- 연산프로퍼티는 값을 저장하는 것이 아니라 연산을 통해서 값을 설정하거나 반환 해준다.( gaki 인스턴스 초기화 시 매개변수로 myMajor가 아닌 university를 사용해서 myMajor의 값을 초기화 시켜주어야한다)


### 연산프로퍼티 settable

```swift
protocol MajorInformed {
	var myMajor: String { get }
}

struct Student: MajorInformed {
	var university: String
	var myMajor: String {
    	
        get {
        
     		return university
        
        }
        set {
        
        	university = newValue
            
        }
    }
}

var gaki = Student(university: "KNU")

gaki.myMajor = "Electric Engineering"  //가능
```

- 프로토콜이 gettable 및 settable 프로퍼티를 요구하면, 해당 프로퍼티 요구사항은 상수(constant) 저장 프로퍼티 또는 읽기 전용 연산 프로퍼티로 충족되서는 안된다.

- `{ set }` 으로 선언 되어있는데 `let`으로 선언이 되어있으면 변수가 settable 하지 않기 때문에 `var` 로 선언

## 2. Method Requirements(메소드 요구사항)

- 프로토콜은 특정 인스턴스 메소드 및 타입 메소드가 타입을 준수하여 구현하도록 요구가 가능하다.

> 프로토콜내 함수 선언

![image](https://user-images.githubusercontent.com/33486820/53578393-f7459880-3bba-11e9-8e5e-f5a21b880813.png)

> 프로토콜 채택

<img width="566" alt="image" src="https://user-images.githubusercontent.com/33486820/53578680-6e7b2c80-3bbb-11e9-8cda-ddadfa16f0d8.png">

- 프로토콜은 단순 정의만 진행하고 실제 구현은 프로토콜을 채택한 곳에서 수행


### 타입 프로퍼티와 프로토콜

- 타입 프로퍼티를 프로토콜에 정의한 경우, 다입베소드 요구사항에 항살 **static** 키워드를 붙여야 한다.

- 클래스에서 구현할 때, 타입 메소드 요구사항 앞에 **class** 또는 **static** 키워드가 접두사로 붙는 경우에도 마찬가지 이다.

```swfit
protocol SomeProtocol {

    static func someTypeMethod()

    static func anotherTypeMethod()

    

}
```

class 에서 채택

```swift
class Gaki : SomeProtocol{

    static func someTypeMethod() {
    }

    class func anotherTypeMethod() {
    }

}
```

gaki라는 클래스에서 `SomeProtocol` 을 채택하고 요구 메서드를 구현 한다. class 에서 프로토콜을 채택했기 때문에 요구 메소드는 static 도는 class 키워드를 추가해서 구현 할 수 있다.

> 서브클래스에서 override를 통해 구현

```swift
class Gaki : SomeProtocol{

    static func someTypeMethod() {
    }

    class func anotherTypeMethod() {
    }

}

class SubClass: Gaki {
	
    override static func anotherTypeMethod() {
    //overriding implementation
    }
}
```

## Mutating Method Requirements

- `Mutating` 키워드는 구조체 또는 열거형에서만 채택시 사용 할 수 있다.

```swift
protocol SomeProtocol{

    mutating func SomeMethod(_ num : Int)

}

struct SomeStruct : SomeProtocol{

    var x = 0
	
    //프로토콜 측에서 이미 mutating을 선언 하고 있기 때문에 구현 시 생략이 가능하다.
    mutating func SomeMethod(_ num :Int) {

        x += num

    }

}
```

- 구조체 내부의 변수 x 의 값을 변경가능하게 하기 위해 [mutating](https://blog.naver.com/guyeongjun/221436864605) 키워드를 통해 변수 x 값에 접근 가능하다.

## Initializer Requirement

- 프로토콜을 준수하려는 타입에게 특정 이니셜라이저를 필수적으로 구현 하도록 요구가 가능하다.

```swift
protocol SomeProtocol {
	
    init(someParameter: Int)
}
```

### Class Implementations of Protocol Initializer Requirements

- 프로토콜을 준수하는 **클래스**에서 프로토콜에서 요구하는 이니셜라이저 요구사항을 구현 할수 있다.

- **required** , **modifier** 키워드를 사용 (구조체의 경우 필요가 없다)

- 클래스가 **final** modifier로 표시 되었을때는 **required** 를 표시할 필요 없다. (final 클래스는 서브클래스화 할 수 없다)


```swift
protocol SomeProtocol {

    init(someParameter: Int)

}

class SomeClass: SomeProtocol {

    required init(someParameter: Int) {

        // initializer implementation goes here

    }

}
```

- **protocol의 init()** 과 **슈퍼클래스의 dssignated init()** 를 재정의 할때 두 이니셜라이저가 일치 하는 경우 **required override** 를 명시한다.


```swift
protocol SomeProtocol {

    init()

}



class SomeSuperClass {

    init() {

        // initializer implementation goes here

    }

}



class SomeSubClass: SomeSuperClass, SomeProtocol {

    // "required" from SomeProtocol conformance; "override" from SomeSuperClass

    required override init() {

        // initializer implementation goes here

    }

}
```

## Protocols as Type (타입으로서의 프로토콜)

- 프로토콜을 채택하는 것이 아니라 타입으로 프로토콜을 변수나 상수 프로퍼티로 선언하는 것

- 해당 프로토콜의 요구 메소드를 구현 할 필요 없이 접근이 가능하다.

```swift
protocol RandomNumberGenerator {

    func random() -> Double

}

class LinearCongruentialGenerator: RandomNumberGenerator {

    var lastRandom = 42.0

    let m = 139968.0

    let a = 3877.0

    let c = 29573.0

    func random() -> Double {

        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))

        return lastRandom / m

    }

}

class Dice {

    let sides: Int
    
	//상수 저장 프로퍼티를 선언 하고 타입을 protocol로 선언
    let generator: RandomNumberGenerator

    init(sides: Int, generator: RandomNumberGenerator) {

        self.sides = sides

        self.generator = generator

    }

    func roll() -> Int {
		//요구메소드를 구현 하지 않고 바로 접근이 가능하다 
    	//주의사항은 타입으로서 프로토콜을 사용할 때 해당 요구 메서드가 완벽하게 오류가 없이 구현이 되어있어야한다.
        return Int(generator.random() * Double(sides)) + 1

    }

}
var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())

for _ in 1...5 {

    print("Random dice roll is \(d6.roll())")

}

```

위의 예제는 해당 프로토콜의 타입의 변수가 선언된 해당 클래스 내에서 구현 없이 접근 하는 것을 볼 수 있다.
이런 것이 가능한 이유는 이전에 해당 프로토콜을 채택한 `LinearCongruentialGenerator` 클래스에서 요구 메서드를 구현 했고 이 클래스 또한 `RandomNumberGenerator` 타입이기 때문에 `Dice(sides: 6, generator: LinearCongruentialGenerator())` 이런 작업이 가능하다.
그러므로 해당 generator의 경우 앞전에 구현된 요구 함수를 접근할 수 있다.


## Adding Protocol Conformance with an Extension

- 프로토콜을 Extension 하여 채택이 가능하다.

```swift
protocol AddString {
	
    var addHello: String { get }
    
}

extension String: AddString {

	var addHello: String {
    	//self :addHello를 호출하는 String 인스턴스 자신
    	return "Hello \(self)"
	}
}
```







