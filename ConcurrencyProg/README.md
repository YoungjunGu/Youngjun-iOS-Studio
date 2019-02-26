# Grand Central Dispatch(GCD)

## GCD란 무엇인가?

멀티코어와 멀티 프로세싱 환경에서 최적화된 프로그래밍을 할 수 있도록 애플이 개발한 기술이다.

## GCD를 사용하는 이유는 무엇인가?

![image](https://user-images.githubusercontent.com/33486820/53392383-8c3e6b00-39dc-11e9-9c10-4b6435284fdb.png)

- 위의 구조를 보면 Main Thread 에서 User Inferface 에 관련 된 모든 코드를 실행한다. 만약 Data transform 이나 image Processing , Networking 등과 같은 작업을 Main Thread에서 모두 진행을 하게 되면 User Interface의 대응이 느려지거나 중지가 되는 일이 벌어진다.

> 해결: GCD 라는 Concurrency Library 를 사용하여 Main Thread의 일을 줄이자!

![image](https://user-images.githubusercontent.com/33486820/53394355-5dc38e80-39e2-11e9-9918-b00d436b5e8e.png)

- GCD를 이해하기 위해서는 우선 [`DispatchQueue`](https://developer.apple.com/documentation/dispatch) 의 개념을 알아야 한다. 말그대로 Queue 의 기능을 수행하는것인데 프로그래머가 실행할 task(작업)들을 운영체제의 관리 하에 비동기적으로 수행한다.
DispatchQueue에 수행할 작업 들을 추가하면 GCD는 task에 맞는 스레드를 자동으로 생성해서 실행하고 작업이 종료되면 해당 스레드를 제거하는 형식으로 수행이 된다.<br> Queue 의 특성상 FIFO(first in first out) 구조로 제일먼저 들어온 task 부터 실행한다.

![image](https://user-images.githubusercontent.com/33486820/53392301-58fbdc00-39dc-11e9-8925-ab66e3c82124.png)

> Dispatch Queue 2가지 종류

- **Serial Dispatch Queue** : 한번에 하나의 작업만을 실행, 해당 작업이 대기열에서 완료후 제외되고 새로운 작업이 시작되기 전까지 기다린다. 

```swift
let serialQueue = DispatchQueue(label: "com.example.serial")
serialQueue.async {
    for i in 0..<10 {
        print("🍏", i)
    }
}
serialQueue.async {
    for i in 100..<110 {
        print("🍎", i)
    }
}
🍏 0
🍏 1
🍏 2
🍏 3
🍏 4
🍏 5
🍏 6
🍏 7
🍏 8
🍏 9
🍎 100
🍎 101
🍎 102
🍎 103
🍎 104
🍎 105
🍎 106
🍎 107
🍎 108
🍎 109
```

- **Concurrent Dispatch Queue** : Serial 과 다르게 기다리지 않는다. 가능한 많은 작업을 말그대로 "Conccrently(동시에)"한다.

```swift
let concurrentQueue = DispatchQueue(label: "com.example.concurrent", attributes: .concurrent)
concurrentQueue.async {
    for i in 0..<10 {
        print("🍏", i)
    }
}
concurrentQueue.async {
    for i in 100..<110 {
        print("🍎", i)
    }
}
🍏 0
🍎 100
🍏 1
🍎 101
🍏 2
🍎 102
🍏 3
🍎 103
🍏 4
🍎 104
🍏 5
🍎 105
🍏 6
🍎 106
🍎 107
🍏 7
🍎 108
🍏 8
🍎 109
🍏 9
```

위의 코드를 실행하면 Serial 과 Concurrent의 차이점을 알 수 있다. Conccurent의 경우에는 순서에 상관 이 없이 동시에  두 task 가 수행되는 것을 확인 할 수 있다.

## 기본적으로 제공하는 Queue 와 custom tpye

앱 실행시에 시스템에서 기본적으로 2개의 Queue 를 제공한다.

- **Main Queue** : 메인 스레드(UI Thread) 에서 사용 되는 **Serial Queue** 이다. 높은 우선순위를 가지고 있다.

- **Global Queue** : 편의상 사용할수 있게만들어 놓은 Concurrent Queue 이다. 전체 시스템에서 공유가 이루어 지고 처리 우선순위를 위해**qos(Quallity of Service)** 매개변수를 제공한다. 병렬적으로 동시에 처리하기 떄문에 작업 완료의 순서는 정할 수 없지만 우선적으로 일을 처리하게 할 수 있다.


```swift
let globalQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass." ")
```

> qos 의 우선순위

1. `userInteractive` : UI 업데이트, 이벤트 처리 및 대기 시작이 적은 작업, Main Thread에서 실행 되어야 한다.

2. `userInitiated` : 사용자가 즉각적인 결과를 기다리고 있고 UI 상호 작용을 계속하는데 필요한 작업에 사용.

3. `default`

4. `utility` : 계산,I/O,네트워킹, 연속적인 데이터 피드 등 지속적인 작업이 필요한 경우에 사용.

5. `background` : 정해진 시간이 없는 작업들

6. `unspecified`

- qos 우선순위에 따른 수행 결과

```swift
let serialQueue1 = DispatchQueue(label: "com.example.serial1", qos: .userInteractive)
let serialQueue2 = DispatchQueue(label: "com.example.serial2", qos: .userInteractive)
serialQueue1.async {
    for i in 0..<10 {
        print("🍏", i)
    }
}
serialQueue2.async {
    for i in 100..<110 {
        print("🍎", i)
    }
}
🍎 100
🍏 0
🍎 101
🍏 1
🍎 102
🍏 2
🍎 103
🍏 3
🍎 104
🍏 4
🍎 105
🍏 5
🍎 106
🍏 6
🍎 107
🍏 7
🍎 108
🍏 8
🍎 109
🍏 9
```

```swift
//qos의 우선순위에 따라 출려되는 순서가 다르다.
let serialQueue1 = DispatchQueue(label: "com.example.serial1", qos: .background)
let serialQueue2 = DispatchQueue(label: "com.example.serial2", qos: .userInteractive)
serialQueue1.async {
    for i in 0..<10 {
        print("🍏", i)
    }
}
serialQueue2.async {
    for i in 100..<110 {
        print("🍎", i)
    }
}
🍏 0
🍎 100
🍎 101
🍎 102
🍎 103
🍎 104
🍎 105
🍎 106
🍏 1
🍎 107
🍏 2
🍎 108
🍎 109
🍏 3
🍏 4
🍏 5
🍏 6
🍏 7
🍏 8
🍏 9
```
   
- **Custom Queue** : Serial or Concurrent 중 하나의 Queue, Global Queue 중 하나에 의해 처리된다.
   
```swift
let mainQueue = DispatchQueue.main
print(mainQueue)	// Main Queue

let globalQueue = DispatchQueue.global(qos: .background)
print(globalQueue)	// Global Queue
```

## Snync / async

Dispatch Queue는 **sync(동기)** 와 **asnyc(비동기)** 메서드를 가지고 있다. 

> **Snycronous** : 동기처리 메서드

해당 작업을 처리하는 동안 다음으로 진행 되지 않고 계속 머물러 있다. Serial Dispatch Queue와 같은 결과가 나타난다.(하지만 다르다는 점 유의 아래에서 설명)

```swift
DispatchQueue.main.sync {
  print("value: 1")
}
print("value: 2")

// 결과
/*
  value: 1
  value: 2
*/
```

- SubSystem 들을 직렬로 처리한다
    
- 안전하게 프로퍼티에 접근이 가능하다 . Mutual exclusion 이 지원된다 (mutex나 semaphore) 그렇지만 **DeadLock** 이 발생 할 수 있다.

**중요: 앱의 모든 UI 작업이 Main queue에서 수행하기 때문에 동기적으로 main 큐에 접근하여 작업을 실행하려고 하면 교착상태(dead-lock)가 발생한다**
    
<img width="1061" alt="image" src="https://user-images.githubusercontent.com/33486820/53394465-bc890800-39e2-11e9-8aab-c7d7419163ed.png">

```swift 
//deadlock 발생 예제
 override func viewDidLoad() {
    super.viewDidLoad()


    print("Start")
    DispatchQueue.main.async {
        print("async")

    }
    //Main 에서 sync를 사용했기 때문에 DeadLock 발생!
    DispatchQueue.main.sync {
        print("sync")
    }
    print("Finish")
}
```

> **Asyncronous** : 비동기처리 메서드

sync와 다리게 처리를 하라고 지시한 뒤 다음으로 넘어가 버리기 때문에 아래와 같은 결과가 나타난다

```swift
let globalQueue = DispatchQueue.global(qos: .background)
globalQueue.async {
  print("value: 1")
}
print("value: 2")

// 결과
/*
  value: 2
  value: 1
*/
```

> 주의! Serial/ Concurrent 와 Sync/ Async는 별개 이다. Serial 이면서 비동기 일수도 있고 Concurrent 이면서 Sync 일수도 있다. Serial 과 Concurrent 는 한번에 하나만 처리하느냐 동시에 여러개 처리하느냐고 Sync/ Async는 처리가 끝날때까지 기다리느냐 지시 후 다른 처리를 하느냐에 초점이 맞추면 된다.



## DispatchWorkItem

DispatchQueue에 삽입하는 작업을 캡슐화 한 것이다.

<img width="943" alt="image" src="https://user-images.githubusercontent.com/33486820/53412901-0a673580-3a0e-11e9-8be0-0fb675894a2a.png">

위와 같이 프로퍼티에 Closure형태로 DispatchWorkItem 을 이용해서 만든 후 아래 execute를 통해 실행을 제어 한다.

- DispatchWorkItem 예제

```swift
let serialQueue = DispatchQueue(label: "firstQueue", attributes: .concurrent)

let firstItem = DispatchWorkItem(qos: .userInitiated) {

	    for i in 0..<10 {
        print("🍏", i)
    }
    
}

let secondItem = DispatchWorkItem(qos: .background) {

		    for i in 100..<110 {
        print("🍎", i)
    }
    
}

//위의 형식 처럼 작업을 클로져 형태로 캡슐화 한뒤 Dispatch Queue에 삽입한다.

serialQueue.async(execute: secondItem)

serialQueue.async(execute: firstItem)

// secondItem 이 우선순위가 낮아 먼저 execute 되어도 대체적으로 ristItem 이 우선적으로 실행 되는 것을 확인 할 수 있다.
🍎 100
🍏 0
🍎 101
🍏 1
🍏 2
🍎 102
🍏 3
🍏 4
🍎 103
🍏 5
🍏 6
🍎 104
🍏 7
🍏 8
🍎 105
🍏 9
🍎 106
🍎 107
🍎 108
🍎 109
```


## Grouping vs Chaining

<img width="894" alt="image" src="https://user-images.githubusercontent.com/33486820/53417020-00e2cb00-3a18-11e9-9377-71ff4005f0b1.png">

- **Grouping** : DispatchQueue 들이 각자의 동작을 수행후 종합해서 최종적으로 수행되는 형태

```swift
//그룹 생성
let queueGroup = DispatchGroup()

let queue1 = DispatchQueue(label: "task1", attributes: .concurrent)
let queue2 = DispatchQueue(label: "task2", attributes: .concurrent)
let queue3 = DispatchQueue(label: "task3", attributes: .concurrent)

queue1.async(group: queueGroup) {
    print("task1")
}

queue2.async(group: queueGroup) {
    print("task2")
}

queue3.async(group: queueGroup) {
    print("task3")
}

queueGroup.notify(queue: DispatchQueue.main) {
    print("group notify")
}
//출력 결과

task1
task2
task3
group notify
```

- **Chaining** 

```swift 

let queue = DispatchQueue(label: "com.example.imageTransform")

queue.async {
	let transformImage = image.resize(to: rect)
    //UI 변화에 관련된 작업은 모두 Main Thread에서 진행 하면 된다.
    DispatchQueue.main.async {
    	imageView.image = transformImage
    }
}
```


<hr>

# Operation Queue

cocoa operations는 비동기적으로 수행하려는 작업(task)를 캡슐화 하는 객체지향적인 방법(Object-oriented way)

> Operatin Queue의 특징

- Operatin은 task와 관련된 코드와 데이터를 나타내는 추상 클래스다.
- Operation Queue는 연산의 실행을 관리한다.
- Queue에 추가한 동작은 직접 제거할 수 없다.
- 연산은 작업이 끝날 때까지 대기열에 남아있다.
- 연산을 대기열에서 제거하는 방법은 연산을 취소하는 방법뿐이다.
- 취소하는 방법은 연산객체(Operation Object)의 `cnacel()` 메서드를 호출하거나 Operation Queue의 `cancelAllOperations()` 메서드를 호출하여 대기열에 있는 모든연산을 취소하는 방법이 있다.
- **연산객체(Operation Object)** : 앱에서 수행하려는 연산을 캡슐화 하는데 사용하는 **Foundation 프레임워크** 의 Operation 클래스 인스턴스이다.

> NSOperation 클래스의 인스턴스인 연산객체

- **NSInvocationOperation** : 앱의 객체 및 selector를 기반하여 연산객체를 만드는데 사용하는 클래스이다.
이미 필요한 작업을 구행하는 기존 메소드가 존재하는 경우 이 클래스를 사용 할 수 있다. 하위클래스가 필요하지 않으므로 이 클래스를 사용하여 보다 동적인 방식으로 연산 객체를 만들 수 있다.

- **NSBlockOperation** : 현재 하나 이상의 블록 객체를 동시에 실행하는데 사용하는 클래스이다. 둘이상의 블록을 실행할 수 있으므로 블록 연산객체는 그룹 semantic을 사용하여 작동한다. 연관된 모든 블럭이 실행을 완료한 경우에만 연산자체가 완료 된 것으로 간주한다.

- **NSOperation**: Custom 연산객체를 정의하기 위한 base class 이다. NSOperatin을 하위 클래스화 하면 연산이 실행되는 기본방식을 변경하고 상태를 보고하는 기능을 포함하여 자체 연산의 구현을 완벽하게 제어 할 수 있다.

> Operation 객체의 주요 지원 기능

- operation객체간의 그래프 기반 종속성 설정 지원. 이러한 종속성은 종속 된 모든 작업이 실행을 완료할 때까지 주어진 operation이 실행되는 것을 방지합니다.
- operation의 main task가 완료된 후에 실행되는 optional completion블록을 지원합니다.(OS X v10.6이상에만 해당)
- KVO알림을 사용하여 operation의 실행 상태 변경 모니터링을 지원합니다.
- operation 우선 순위 지정을 지원하므로, 상대적인 실행 순서에 영향을 줍니다. 
- 실행 중 조작을 정지 할 수 있는 canceling semantics기능을 지원합니다.

출처: [ZeddiOS](https://zeddios.tistory.com/510 )


## OperationQueue의 주요 메서드/프로퍼티

> 특정 Operation Queues 가져오기

```swift
//current : 현재 작업을 시작한 Operation Queue를 반환합니다.
class var current: OperationQueue? { get }

//main : 메인 스레드와 연결된 Operation Queue를 반환합니다.
class var main: OperationQueue { get }
```

> 대기열(Queue)에서 동작(Operation) 관리

```swift
//addOperation(_:) : 연산 객체(Operation Object)를 대기열(Queue)에 추가합니다.
 func addOperation(_ op: Operation)
 
//addOperations(_:waitUntilFinished:) : 연산 객체(Operation Object) 배열을 대기열(Queue)에 추가합니다.
func addOperations(_ ops: [Operation], waitUntilFinished wait: Bool)

addOperation(_:) : 전달한 클로저를 연산 객체(Operation Object)에 감싸서 대기열(Queue)에 추가합니다.
func addOperation(_ block: @escaping () -> Void)

//cancelAllOperations() : 대기 중이거나 실행 중인 모든 연산(Operation)을 취소합니다.
func cancelAllOperations()

//waitUntilAllOperationsAreFinished() : 대기 중인 모든 연산(Operation)과 실행 중인 연산(Operation)이 모두 완료될 때까지 현재 스레드로의 접근을 차단합니다.
 func waitUntilAllOperationsAreFinished()
 ```
 
 > 연산(Operation) 실행 관리
 
 ```swift
 //maxConcurrentOperationCount : 동시에 실행할 수 있는 연산(Operation)의 최대 수입니다.
 var maxConcurrentOperationCount: Int { get set }
 
//qualityOfService : 대기열 작업을 효율적으로 수행할 수 있도록 여러 우선순위 옵션을 제공합니다.
 var qualityOfService: QualityOfService { get set }
 ```
 
 > 연산(Operation) 중단
 
 ```swift
 
//isSuspended : 대기열(Queue)의 연산(Operation) 여부를 나타내기 위한 부울 값입니다. false인 경우 대기열(Queue)에 있는 //연산(Operation)을 실행하고, true인 경우 대기열(Queue)에 대기 중인 연산(Operation)을 실행하진 않지만 이미 실행 중인 연산(Operation)은 계속 실행됩니다.
var isSuspended: Bool { get set }

대기열(Queue)의 구성
//name : Operation Queue의 이름
 var name: String? { get set }
```



참고 자료

Operation Queue
- https://medium.com/flawless-app-stories/parallel-programming-with-swift-operations-54cbefaf3cb0
- https://zeddios.tistory.com/510

GCD
- https://www.appcoda.com/grand-central-dispatch/
- https://developer.apple.com/documentation/dispatch/dispatchqueue
- https://developer.apple.com/videos/play/wwdc2016/720/

- https://www.edwith.org/boostcourse-ios/








