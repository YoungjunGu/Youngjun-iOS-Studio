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


















