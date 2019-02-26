# Grand Central Dispatch(GCD)

## GCD란 무엇인가?

멀티코어와 멀티 프로세싱 환경에서 최적화된 프로그래밍을 할 수 있도록 애플이 개발한 기술이다.

## GCD를 사용하는 이유는 무엇인가?

![image](https://user-images.githubusercontent.com/33486820/53392383-8c3e6b00-39dc-11e9-9c10-4b6435284fdb.png)

- 위의 구조를 보면 Main Thread 에서 User Inferface 에 관련 된 모든 코드를 실행한다. 만약 Data transform 이나 image Processing , Networking 등과 같은 작업을 Main Thread에서 모두 진행을 하게 되면 User Interface의 대응이 느려지거나 중지가 되는 일이 벌어진다.

> 해결: GCD 라는 Concurrency Library 를 사용하자 !

![image](https://user-images.githubusercontent.com/33486820/53392301-58fbdc00-39dc-11e9-8925-ab66e3c82124.png)

- GCD를 이해하기 위해서는 우선 [`DispatchQueue`](https://developer.apple.com/documentation/dispatch) 의 개념을 알아야 한다. 말그대로 Queue 의 기능을 수행하는것인데 프로그래머가 실행할 task(작업)들을 운영체제의 관리 하에 비동기적으로 수행한다.
DispatchQueue에 수행할 작업 들을 추가하면 GCD는 task에 맞는 스레드를 자동으로 생성해서 실행하고 작업이 종료되면 해당 스레드를 제거하는 형식으로 수행이 된다.<br> Queue 의 특성상 FIFO(first in first out) 구조로 제일먼저 들어온 task 부터 실행한다.

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
	- qos 의 우선순위
    	1. userInteractive
        2. userInitiated
        3. default
        4. utility
        5. background
        6. unspecified
   
- **Custom Queue** : Serial or Concurrent 중 하나의 Queue, Global Queue 중 하나에 의해 처리된다.
   
```swift
let mainQueue = DispatchQueue.main
print(mainQueue)	// Main Queue

let globalQueue = DispatchQueue.global(qos: .background)
print(globalQueue)	// Global Queue
```

## Snync / async

Dispatch Queue는 **sync(동기)** 와 **asnyc(비동기)** 메서드를 가지고 있다. 

- Snycronous: 동기처리 메서드
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
    

- Asyncronous: 비동기처리 메서드
sync와 다리게 처리를 하라고 지시한 뒤 다음으로 넘어가 버리기 때문에 아래와 같은 결과가 나타납니다.

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








    
    






