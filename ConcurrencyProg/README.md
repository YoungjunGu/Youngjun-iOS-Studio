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

- Serial Dispatch Queue : 한번에 하나의 작업만을 실행, 해당 작업이 대기열에서 완료후 제외되고 새로운 작업이 시작되기 전까지 기다린다. 

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

- Concurrent Dispatch Queue : Serial 과 다르게 기다리지 않는다. 가능한 많은 작업을 말그대로 "Conccrently(동시에)"한다.

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







