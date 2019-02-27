# 클로저 & 고차함수 (Closure & High OrderFunction )


# 클로저(Closure)

swift의 함수형 프로그래밍을 이해 하기위에 필수적인 개념

클로저? 함수? 함수는 클로저의 형태?

swift 의 함수형 프로그래밍을 이해 할려면 그 기초가 클로저를 우선 이해하는 거 에서 부터 시작한다고 합니다.

그만큼 클로저가 중요하고 또한 추후에 정리해서 올릴 함수형 프로그래밍를 이해하는데 중요한 개념입니다.



swift 의 책이나 공식문서에서는 클로저의 유래와 정의를 이렇게 정리 해놓았습니다.



클로저는 일정 기능을 하는 코드를 하나의 블록으로 모아놓은 것을 말합니다.

클로저는 변수나 상수가 선언된 위치에서 참조(Reference) 를 획득(Capture) 하고 저장할수 있고, 이를 변수나 상수의 클로징(잠금)이라고 하며 클로저는 여기서 착안된 이름입니다.

-야곰 Swift4 개정판-

클로저는 어떤것인지 이미 우리는 사용하고있습니다.

클로저의 여러가지 모양 중 하나가 바로 "함수" 입니다.



그럼 어떤 부분에서 함수가 클로저의 형태라고 할 수 있을까요 ? 클로저는 크게 3가지 형태로 나눌 수 있습니다.



- 이름이 있으면서 어떤 값도 획득하지 않는 전역함수의 형태

- 이름이 있으면서 다른 함수 내부의 값을 획득할 수 있는 중첩된 함수의 형태

- 이름이 없고 주변 문맥에 따라 값을 획득할 수 있는 축약 문법으로 작성한 형태

> 클로저의 형태


```swift
{ (매개 변수) -> 반환 타입 in
   실행 코드
}
```


이렇게 말로 설명 하면 어떤 형태인지 잘 안와닿으실 겁니다... 저 또한 마찬가지입니다.

그럼 클로저의 문법은 어떠하고 사용법은 무엇인지 실용적으로 파고 들어 보겠습니다!



스위프트 표준 라이브러리에는 배열의 값을 간편하게 정렬을 시켜주는 `sorted(by:)` 메서드 가 있습니다.

`sorted(by:)` 메서드의 특징은 기존 배열은 값을 변경하지 않고 새롭게 정렬된 배열을 반환 한다는 것입니다!

```swift
public func sorted(by areInIncreasingOrder: (Element1, Element2) -> Bool) -> [Element]
```

sorted(by:) 메서드의 형태는 배열의 타입과 같은 두개의 매개변수를 가지고 Bool 타입을 반환 하는 클로저를 전달인자로 받을수 있습니다.

쉽게 말해서 Element1 과 Element2 의 정렬 순서를 Bool 값으로 결과값을 반환하는 것입니다 . 

True 가 나오게 되면 Element1 이 2 보다 먼저 정렬이 됩니다.

> 클로저를 사용하지 않고 함수 전달 시

```swift 
let names: [String] = ["x", "c", "b", "a", "k"]

func backwards(first: String, second: String) -> Bool {
	print("\(first) \(second) 비교중")
    return first < second
}

let reversed: [String] = names.sorted(by: backwards)
print(reversed)

//출력
c x 비교중
b x 비교중
b c 비교중
a x 비교중
a c 비교중
a b 비교중
k x 비교중
k c 비교중
["a", "b", "c", "k", "x"]
```

"굳이 이렇게 할 필요가 있나?.." 라는 생각이 문득 들 수 있습니다.

first < second 의 값을 얻기위해 코드의 양도 늘어나고 매개변수 표현부도 늘어나 가독성과 효율이 떨어집니다!


> 클로저를 사용

```swift
let reversed: [String] = names.sorted(by: { (first: String, second: String) -> Bool in
    return first < second
})

print(reversed)
```


직관적으로 눈에 보이시나요? 클로저를 왜 사용하느지 보여주는 예제입니다

굳이 backwards 라는 함수를 선언 하지 않고서 클로저의 값 반환을 이용하여 바로 reversed 배열에 대입하는 것을 볼 수 있습니다.

- 불필요한 함수 선언을 줄이고 직관적이다.

비록 지금은 함수 선언하는게 편하다고 하실 수 있겠지만 나중에 협엽을 하거나 한 프로젝트에 엄청나게 많은 함수가 존재 할 때 

함수를 찾지 않아도 그때그때 해당 기능을 수행하는 클로저를 저런식으로 정의하여 사용하게 되면 직관적으로 보일 수 있겠습니다.

-함수를 선언 하여 사용하거나 클로저를 사용하여 직관적으로 나타내는 것은 사용자의 몫


> 후행 클로저

후행 클로저는 기본 클로저의 사용 방법보다 조금 더 가독성을 위한 개념이라고 생각 하시면 됩니다.


```swift
let reversed: [String] = names.sorted() { (first: String, second: String) -> Bool in
    return first < second
}
```

위에 보시는 것 처럼 후행으로 클로저를 선언하여 하용 할 수 있고 sorted 메서드의 매개변수 소괄호 ' () ' 도 생략 가능합니다.

> 타입을 자동으로 유추 해주는 클로저

```swift
let reversed: [String] = names.sorted { (first, second) in
    return first < second
}
```

sorted 메서드의 클로저의 매개변수 타입과 반환 타입인 String 과 Bool 을 생략 할 수 있습니다.
왜냐 하면 sorted 메서드에서 이미 위 두 타입을 준수하고 있다고 유추 할 수 있기 때문입니다. 
고로 이제 매개변수 타입을 생략하여! 더 간결하고 간편하게 사용 할 수 있습니다.

> first? second 필요 있을까?

sorted(by:) 메서드로 전달 되는 두 매개변수 first와 second 가 굳이 필요 있을까요?
물론 가독성을 위해 선언하는 것은 괜찮을 지 모르지만 의미가 사실 없어 보입니다. 그렇기 때문에 이 또한 생략이 가능한데요

```swift
let reversed: [String] = names.sorted {
    return $0 > $1
}
```

이렇게 매개변수를 $0 $1 $2 $3 ... $n 형식으로 사용 할 수 있습니다.

위의 $0 $1 은 각각 first second 입니다. 

그리고  정의부와 실행부를 구분 지었던 in 또한 경계가 허물어 졌기 떄문에 생략이 가능해졌습니다.

> return도 생략 가능

```swift
let reversed: [String] = names.sorted { $0 > $1 }
```

> 연산자 함수에서 클로저

연산자  ' > ' 또한 함수 이름이기 때문에 두 매개변수를 비교하여 Bool 타입의 값을 반환 시켜 주는 함수 입니다.

Generic을 사용한게 보입니다. 그렇기 때문에 비교 인자로 들어오는 매개변수는 어떤 타입이든 두 타입이 동일하기만 하면 > 함수를 수행하여 Bool 타입값으로 반환 해줍니다.

```swift
public func ><T: Comparable>(lhs: T, rhs: T) -> Bool

let reversed: [String] = names.sorted(by: >)
```

### 값 캡쳐(Capturing Values)

클로저는 특정 문맥의 상수나 변수의 값을 캡쳐할 수 있다. 즉 원본 값이 사라져도 클로져의  body 안에서 그 값을 활용할 수 있다. Swift에서 값을 캡쳐 하는 가장 단순한 형태는 **중첩함수 (nested function)** 이다. 중첩함수는 함수의 body 에서 다른 함수를 다시 호출하는 형태로 된 함수이다.

```swift
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
	var runningTotal = 0
    func incrementer() -> Int {
    	runningTotal += amount
        return runningTotal
        }
	return incrementer
}
```

위 함수는 `makeIncrementer` 함수 안에서 `incrementer`함수를 호출하는 형태의 중첩함수 이다.
처음 `(forINcrement amount: Int)` 는 중첩함수의 인자가 들어오는 매개변수 부분이다. 그리고 반환값으로
`() -> Int` 이다 . 즉 클로저의 형태의 반환 값을 그 형태는 Int 형이라는 말이다.


```swift
let incrementByTen = makeIncrementer(forIncrement: 10)
```

위의 중첩 함수를 실행 시켜 보면 반환 값이 클로저의 형태이기 때문에 아래와 같이 프로퍼티를 함수 형태로 실행이 가능하다

```swift
incrementByTen()
// 값으로 10을 반환
incrementByTen()
// 값으로 20을 반환
incrementByTen()
// 값으로 30을 반환
```

주목해야 할 점은 위의 코드에서  runningTotal의 값과 amount 값이 **캡처**가 되었기에 값이 증가하는 것을 확인 할 수 있다.

해당 `incrementByTen`은 앞으로 프로젝트 내에서 실행이 멈출때 까지 값은 계속 캡쳐가 되고 다른 프로퍼티로 생성우 중첩함수를 사용하면 해당 프로퍼티는 새로운 클로저반환타입을 받기 떄문에 이전의 클로저와 전혀 별개로 수행을 한다

### 클로저는 참조 타입(Closures Are Reference Type)

하나의 클로저를 두 상수나 변수에 할당하면 해당 상수,변수는 같은 클로저를 **참조** 하고있다.
C/C++의 함수 포인터와 같은 개념이다.

```swift
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()
// 50을 반환
```

# Escaping Closures

> 함수가 반환된 후 실행 되는 Escaping Closure


클로저를 함수의 파라미터로 넣을 수 있는데, 함수 밖(함수 종료)에서 실행되는 클로저들
비동기로 실행되거나 completionHandler 로 사용되는 클로저는 파라미터 타입 앞에 **@escaping** 이라는 키워드를 명시해야한다.


```swift
var completionHandlers: [() -> Void] = []

func someFunctionWithEscapingClosure(completionHandler: @escaping() -> Void)
	completionHandlers.append(completionHandler)
    
}
```

인자로 전달된 completionHandler는 someFinctionWithEscapingClosure 함수가 끝나고 나중에 처리 된다. 만약 함수가 실행되는 클로저에 @escaping 키워드를 붙이지 않으면 컴파일 시 오류가 발생한다.


> Escaping Closuer를 활용하면 함수 사이에 실행 순서를 정할 수 있다.

함수의 실행순서를 보장 받는 것은 상당히 중요한 기능이다. 이 순서 보장은 **비동기 함수** 의 경우도 포함하기 때문이다. 서버에서 Json 형식의 데이터를 가져와 화면에 이를 보여주는 앱을 예로들어보자. HTTP 통신을 위해 `Alamofire` 라이브러리를 사용한다. 

```swift
Alamofire.request(urlRequest).reponseJSON { response in
	// handle response
}
```

`Alamofire.reuqest()` 메서드는 서버로 Request 를 전송한다. 여기서는 GET 방식으로 Json 형식의 데이터를 받아온다. 그리고 결과는 Response 객체를 통해 받을 수 있다. 일반적으로 Request , Response 작업은 비동기로 작동하고 Request 후 반환되어 버린다. 그렇기 때문에 Escaping Closure 를 통해 제어가 가능하다.

```swift
@discardableResult
    public func responseJSON(
        queue: DispatchQueue? = nil,
        options: JSONSerialization.ReadingOptions = .allowFragments,
        completionHandler: @escaping (DataResponse<Any>) -> Void)
        -> Self
    {
		
    }
```    

reponseJSON 메서드의 매개변수인 queue와 options은 기본값이 지정되어있다.
이 함수에서 핵심은	`completionHandler: @escaping (DataResponse<Any>) -> Void` 이다

우선 `reponseJSON(queue:options:completionHandler:)` 함수가 반환되어 **완전히 서버로부터 값을 가져온 상태에서**  `{ response in }`  에서 실행된다.


> 클로저를 함수 외부에 저장

```swift
// 클로저를 저장하는 배열
var completionHandlers: [() -> Void] = []

func withEscaping(completion: @escaping () -> Void) {
    // 함수 밖에 있는 completionHandlers 배열에 해당 클로저를 저장
    completionHandlers.append(completion)
}

func withoutEscaping(completion: () -> Void) {
    completion()
}

class ClosuerTest {
    var x = 10
    func callFunc() {
        withEscaping { self.x = 100 }
        withoutEscaping { x = 200 }
    }
}
let myClosure = ClosuerTest()
myClosure.callFunc()
//callFunc()를 호출 한 후 완전히 끝난 뒤 클로저를 저장하는 배열에 클로저를 저장
print(myClosure.x)
completionHandlers.first?()
print(myClosure.x)
```

`completionHandlers.appens(completion)` 코드를 통해 `withEscaping(completion:)` 외부에 클로저를 저장한다. 즉, 클로저가 함수에서 탈출했다.
이로서 클로저를 외부로 탈출하는 것이 가능한 것이다.

> Async Inside Async

Escaping Closure는 HTTP 통신에서 completionHandler로 많이 사용된다.
Architecture Pattern 에 따라 다르겠지만 기본적으로 Restful API 기반의 Request들은 프로젝트 내에 여러곳에서 사용되기 때문에 Model을 만들어 통신을 구현하는 것이 일반적이다.

```swift
class Server {
	static getUser() {
    //
    }
}
```

예를 들어 친구의 목록을 서버에서 Json 형태로 가져와 TableView에 나열 해야하는 작업을 해야한다.
이때 주의를 해야할 것은 **데이터를 가져오는것** 과 즉각적인 **UI 화면 Update** 가 보장 되어야한다는 것 이다.
앱이 화면의 UI를 업데이터 하는 도중 데이터가 없어서 크래시가 나는 상황이 발생하기 때문에 두개의 Escaping Closure를 함께 사용해야한다.

```swift
class Server {
    static var users: [UserModel] = []
    
    static getUser(completion: @escaping (Bool, [UserModel]) -> Void) {
        //2
        Alamofire.request(urlRequest).responseJSON { reponse in
            users.append(유저)
            DispatchQueue.main.async {
                //3
                completion(true, users)
            }
        }
    }
}

//1
Server.getUser{ (isSuccess, users) in
    //4
    if isSuccess {
    //성공했기 때문에 UI Update 작업 수행
    }
}
```

> 코드 작동 순서

- 해당 ViewController에서 필요한 데이터를 Server 클래스의 함수 `getUser(completion:)` 을 통해 호출한다.

- Alamofire를 통해 서버로 Request를 전송하고, responseJson은 Escaping Closure이므로 `{ response in }` 부분은 결과가 모두 들어 온 이후에 실행됩니다.(즉 클로저를 탈출 한 다음에 수행)

- responseJson의 completionHandler 이 실행되고, 화면 업데이트를 위해 서버로부터 받아온 데이터(users)를 처음 호출했던 ViewController 쪽으로 보내기 위해, `getUser(completion:)` 의 completion을 호출합니다. 그런데 이 때, **화면 업데이트는 Main 쓰레드에서 이뤄져야하므로, completion은 Escaping Closure 형태를 취합니다.**

- 호출된 completion으로 `getUser(completion:)` 메소드의 completion 블럭이 실행됩니다. 이 때, 통신이 잘 되었는지, 확인하는 Boolean을 isSuccess로 넘기고, 데이터를 persons로 넘겼습니다. 그 이후 화면을 업데이트하면 앱에서 서버의 데이터를 문제 없이 받아오게 됩니다.




## 고차함수 ( High Order Function )

하나 이상의 함수를 인자로 취하거나 함수를 결과로 반환하는 함수

- **map**
- **filter***
- **reduce**

### map












참고자료

[Escaping Closuer](https://hcn1519.github.io/articles/2017-09/swift_escaping_closure)















