# 프로토콜(Protocol) 기본 / Pop (Protocol Oriented Programming)

> 기본을 충실하게!

## 프로토콜(Protocol) 이란?

- 작업에 필요한 메서드,프로퍼티 및 요구사항을 정의하는 일종의 **약속, 계약** 의 역할을 한다. 그후 프로토콜 클래스, 구조체, 열거형에서 채택(adoption)하여 이러한 요구 사항을 자세하게 실제 구현할 수 있다.

> 프로토콜 선언

![image](https://user-images.githubusercontent.com/33486820/53578393-f7459880-3bba-11e9-8e5e-f5a21b880813.png)

> 프로토콜 채택

<img width="566" alt="image" src="https://user-images.githubusercontent.com/33486820/53578680-6e7b2c80-3bbb-11e9-8cda-ddadfa16f0d8.png">

- 프로토콜은 단순 정의만 진행하고 실제 구현은 프로토콜을 채택한 곳에서 수행

## 프로토콜 내의 프로퍼티 선언 

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

var gaki = Student(university: "CES")

gaki.myMajor = "Electric Engineering" // error 발생 
```


   





