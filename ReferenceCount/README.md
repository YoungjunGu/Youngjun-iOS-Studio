# Referece Counting  

**애플의 메모리 관리 방법** 중 하나이다.  
메모리를 할당하거나, 메모리 포인터를 참조 할 때 레퍼런스 카운트를 증가시키고, 사용을 완료하면 reference count를 감소시킨다.  

## Class 객체 생성시의 Reference Counting  

```swift
class Starcraft{}

var terran = Starcraft()
```  

위의 형태로 Starcraft 클래스 인스턴스를 생성할때 메모리내에서 Heap영역에 인스턴스가 생성이 되고 해제가 된다.  
Heap의 경우 메모리를 할당했으면 해제가 반드시 필요하다.  
C의 경우에는 `free,delete`등을 소프트웨어 적으로 개발자가 직접구현해서 사용하고 Java의 경우 가비지 컬렉터가 이를 수행하며 메모리를 해제한다.  
그 중에서 Swift의 경우에는 **Reference Count기법**을 통해 메모리를 할당하고 해제하는 기법을 제공한다.  

- 참조를 하고 있으면 Reference Count를 1 증가
- 더이상 사용하지 않는 다면 Reference Count 1 감소
- **아무런 문제**가 발생하지 않고 무사히 Reference Count가 0이 되면 해제 

</br>

```swift
var marine: Starcraft?
var medic: Starcraft?

// 마린과 메딕이 테란을 참조
marine = terran
medic = terran
```  

위의 경우 마린과 메딕이 테란 객체를 참조하고 있고 이때의 Starcraft 클래스의 인스턴스에 대한 Reference Count 는 3이 된다. 그런다음

```swift
terran = nil
medic = nil
```  

테란과 메딕의 참조를 nil로 대입하면서 해지하게 되면 아직 마린의 참조가 남아있기 때문에 Reference Count의 값은 1 이 되고 결국 마린도 `marin = nil`을 하게 되면 참조값은 0이되고 Starcraft 클래스 인스턴스가 메모리에서 해지된다.  

위에서 **아무런 문제**가 없다는 것을 보장 하기 위해 **Ownership 정책**이라고한다. **1을 증가시켰으면 반드시 1을 감소**가 보장이된다는 정책이다.  
만약 이것이 잘 지켜지지 않는다면 용량이 큰 파일들이나 객채를 참조하고 있는 것들이 해제가 되지 않아 쌓이게 되고 메모리가 부족하여 메모리 워닝이 발생, 결국에는 앱이 뻗어버리는 사태가 발생하게 된다.  

</br>

## Referece Cycle  

**순환참조**, 참조가 모두 해제가 되어야 인스턴스의 메모리 해제가 이루어 지지만 이것이 서로를 서로가 참조하는 상황이 발생하게 되고 어느 누구도 먼저 해제를 하지 못하는 상황이 발생하게 된다.

<img width="574" alt="image" src="https://user-images.githubusercontent.com/33486820/58219683-c488e780-7d46-11e9-8421-5c2362e8d964.png">

위의 경우 A, B 각각의 변수가 자기자신의 클래스 인스턴스를 참조하고 있는 상황에서, A ,B 변수 모두 참조를 nil을 대입하여 끊어도 두 클래스 인스턴스가 이미 **강하게** 참조를 하고 있기 때문에 Reference Count의 횟수가 줄지를 않고 메모리에 그대로 남아있게 된다. 이런 문제점이 발생하기 때문에 swift에서는 아래 키워드를 제공하여 

- strong
- weak
- unowned  

<img width="571" alt="image" src="https://user-images.githubusercontent.com/33486820/58219551-4af0f980-7d46-11e9-985f-f640ee6b90f1.png">  

둘 중 하나의 인스턴스가 먼저 놓게 되는 상황을 만들어 자연스럽게 메모리 해제를 유도하는 방식을 제공하고 있다.










