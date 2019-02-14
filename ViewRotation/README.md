# iOS Device Rotation(화면 회전) 처리

화면을 회전 할때 레이아웃이 변경되고 오토레이아웃을 사용한다해도 화면을 제어해야하는 경우가 몇가지 있어서 정리를 하겠습니다.
본 정리는 [iOS 디바이스 회전 처리](https://medium.com/@jongwonwoo/ios-디바이스-회전-처리에-대한-정리-340f37204a27)를 토대로 정리한 글 임을 밝힙니다.

> Device를 회전할때 지원 되는 두가지 방법

- 직접 회전을 허용하는 방법
- AppDelegate에 회전감지 함수를 추가하는 방법




> 직접 회전을 허용하는 방법

<img width="984" alt="image" src="https://user-images.githubusercontent.com/33486820/52784057-2fb38580-3097-11e9-833e-a03d3bd73810.png">

General에 Deployment Info영역에서 Devie Orientation을 허용하고 싶은 방향으로 체크하면 된다.

> AppDelegate에 회전감지 함수를 추가하는 방법

Portrait(세로모드) 인지 Landscape(가로모드)인지 반환 해주는 함수 추가

```swift
func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
    return [.portrait, .landscape]
}
```

Navigation Controller 에서 회전을 제어하기 위해서는 Navigation Controller를 상속 후 

```swift
//
override var shouldAutorotate: Bool {
    return (self.topViewController?.shouldAutorotate)!
}
override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return (self.topViewController?.supportedInterfaceOrientations)!
}
```



