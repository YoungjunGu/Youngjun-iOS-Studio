- [App Life Cycle](#App-Life-Cycle)
- [ViewController Life Cycle](#ViewController-Life-Cycle)

# App Life Cycle 

앱 생명 주기는 크게 두가지 상태등을 정의해 놓은 일종의 "앱이 실행이 되었다가 사라지는" 하나의 과정이라고 할 수 있다.  


## Swift의 앱 실행 

- `UIApplication` 객체 생성  
	싱글톤 객체로 Event Loop에서 발생하는 여러 이벤트 들을 감지하고 Delegate에 전달하는 역할을 한다. 예를 들어 앱이 백그라운드로 갈때, 메모리 부족 경고를 할 때와 같은 상황들을 감지하여 Delegate에 전달한다.  
        
- `@UIApplicationMain` 어노테이션이 있는 클래스를 찾아 `AppDelegate` 객체를 생성  

- `Main Event Loop`를(touch, text input 등 유저의 액션을 받는 루프) 실행 및 기타 설정  


## AppDelegate  

- AppDelegate객체  
	AppDelegate 객체는 UIApplication 객체로 부터 메시지를 받았을 때, 해당 상황에서 실행 될 함수들을 정의한다. 

app delegate는 **AppDelegate클래스의 인스턴스**, app delegate는 앱의 상태에 따라 응답하는 콘테츠가 그려지는 **창(window)** 를 만든다.  

> AppDelegate.swift 있으므로 AppDelegate클래스가 만들어지고, 이 AppDelegate 클래스에 인스턴스인 app delegate가 앱 내용이 그려질 창(window)를 만든다.  


- AppDelegate.swift는 entry point와, 앱의 입력 이벤트를 전달하는 run loop를 생성한다.  

<img width="321" alt="image" src="https://user-images.githubusercontent.com/33486820/58061834-d9347680-7bb2-11e9-875a-862b1820b9eb.png">  

`@UIApplicationMain` 어노테이션에 의해 AppDeleage.swift 파일 자체가 객체가 된다 즉 UIApllicationMain함수를 호출하고 AppDelegate클래스의 이름을 delegate 클래스에 전달하는 것과 동일하다.  

그 후 시스템은 이에대한 응답으로 **응용프로그램 객체(application object)** 를 생성한다. application object는 **App의 Life Cycle**을 담당한다.  

또한 시스템은 AppDelegate클래스의 객체를 생성하고 이를 application object에 할당한다.  

최종적으로, 시스템은 앱을 실행한다.  

AppDelegate클래스는 새 프로젝트를 만들 때 마다 자동으로 생성된다. 

<img width="473" alt="image" src="https://user-images.githubusercontent.com/33486820/58094257-2fcd9f00-7c0b-11e9-9ef5-4ab47b192cec.png">

- `UIApplicationDelegate`  

AppDelegate클래스는 UIApplicationDelegate 프로토콜을 체택한다.  
이 프로토콜은 앱을 세팅하고, 앱 상태 변화에 응답하며 다른 app-level이벤트를 처리하는 데 사용하는 여러가지 방법을 정의한다.  

- AppDelegate의 window 프로퍼티  

<img width="733" alt="image" src="https://user-images.githubusercontent.com/33486820/58094491-cac67900-7c0b-11e9-95a2-3378dd29ba94.png">  

이 프로퍼티는 앱의 창(window)에 대한 **참조**를 저장한다.  
이 window는 앱의 view계층구조의 **루트**를 나타낸다. 이는 앱 콘텐츠가 모두 그려지는 곳이다. window프로퍼티는 **Optional 프로퍼티**이다.  
즉, nil 값이 될수있는 것을 허용한다는 것이다.  

- AppDelegate 클래스의 delegate 메서드  

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool

func applicationWillResignActive(_ application: UIApplication)

func applicationDidEnterBackground(_ application: UIApplication)

func applicationWillEnterForeground(_ application: UIApplication)

func applicationDidBecomeActive(_ application: UIApplication)

func applicationWillTerminate(_ application: UIApplication)
```  

위의 delegate 메서드를 사용하면, **응용프로그램 객체(application object)가 app delegate(객체)와 통신이 가능하다**.  
앱상태가 전환되는 동안(background ,foreground) 응용프로그램 객체는 위 메서드들 중 해당하는 delegate 메서드를 호출하여 앱이 응답 할 수 있는 기회를 제공한다.  
자동으로 반드시 수행되기 때문에 따로 호출에 대한 작업을 할 필요는 없고, 응용프로그램 객체가 해당 작업을 알아서 처리한다.  

## 앱의 5가지 실행 상태  

- Not Running: 앱이 실행되지 않는 상태  
	(Inactive 와 Active 상태를 합셔서 **Foreground**라고 한다.)  
    
- Inactive: 앱이 실행중인 상태 그러나 아무런 이벤트를 받지 않는 상태  

- Active: 앱이 실핼중이며 이벤트가 발생한 상태  

- Backround: 앱이 백그라운드에 있는 상태 그러나 실행되는 코드가 있는 상태

- Suspened: 앱이 백그라운데 있고 실행되는 코드가 없는 상태  

### AppDelegate 클래스의 Delegate 메서드  

```swift
// 앱이 처음 시작될 때 실행
func application(_:didFinishLaunchingWithOptions:)

// 앱이 Active 에서 Inactive로 이동될 때 실행
func applicationWillResignActive(_ application: UIApplication)

// 앱이 Background 상태일 때 실행
func applicationDidEnterBackground(_ application: UIApplication)

// 앱이 Background에서 Foreground로 이동 될때 실행(아직 Foreground에서 실행중이진 않는다)
func applicationWillEnterForeground(_ application: UIApplication)

// 앱이 Active 상태가 되어 실행 중일 때
func applicationDidBecomeActive(_ application: UIApplication)

// 앱이 종료될 때 실행
func applicationWillTerminate(_ application: UIApplication)
```

</br>


# ViewController-Life-Cycle  

<img width="845" alt="image" src="https://user-images.githubusercontent.com/33486820/58097611-c94c7f00-7c12-11e9-984c-6bda46cb03cd.png">


## viewDidLoad  


> "Called after the controller's view is loaded into memory"  

뷰의 컨트롤러가 메모리에 로드되고 난 후에 호출된다.  
해당 메서드는 뷰의 로딩이 완료 되었을때 **시스템에 의해 자동으로 호출**되기 때문에 일반적으로 리소스를 초기화하거나 초기 화면을 구성하는 용도로 주로 사용한다.  
화면이 처음 만들어질 때 한번 실행하므로 **처음 한번 만 실행해야하는 코드의 초기화 기능**을 이메서드내에 코드를 작성하면 된다.  

</br>

## viewWillAppear  

<img width="937" alt="image" src="https://user-images.githubusercontent.com/33486820/58098344-4fb59080-7c14-11e9-8573-96fd605ccc35.png">  

위의 그림 처럼 초기에 A view는 `viewDidLoad()` 와 `viewWillAppear()`이 모두 호출된다. A에서 B로 view이동이 일어날때도 마찬가지로 B view의 `viewDidLoad()` 와 `viewWillAppear()`이 호출된다. 하지만 B에서 A로 다시 돌아갈 경우 `viewDidLoad()`의 경우 화면이 처음 만들어질 때 한번만 실행하므로 `viewWillAppear()`만 호출이 되는 것을 볼수있다.  
**다른 뷰에서 갔다가 다시 돌아오는 상황에 해주고 싶은 처리를 viewWillAppear에서한다.**  

![image](https://user-images.githubusercontent.com/33486820/58109039-d6c03400-7c27-11e9-87ff-083283dc60f7.png)  


> 참고: 네비게이션 컨트롤러의 경우 view가 stack 처럼 쌓이기 때문에 A에서 B로 갔다가 B 에서 다시 A로 올경우 A의 viewDidLoad()함수는 호출이 되지 않는다. A의 경우 메모리 스택에 남아 있고 B의 경우 A로 back 을 하게 될경우 pop이 수행이 되어 메모리 스택에서 사라지게 되고 결국 다시 B를 이동하게 될때 처음 로드 되는 것처럼 메모리스택에 push 되고 viewDidLoad()가 호출되게 된다.  


</br>

## viewDidAppear  

뷰가 나타났다는 것을 Controller에게 알리는 역할을 한다. 또한 화면에 적용될 애니메이션을 그려준다.  
뷰가 화면에 나타난 직후에 실행되기 때문에 이것을 제외하고는 `viewWillAppear()`와 거의 흡사하다.  

</br>

## viewWillDisappear  

뷰가 사라지기 직전에 호출되는 함수로써, 뷰가 삭제되려고 하는 것을 ViewController에게 통지한다.  

## viewDidDisappear 

ViewController가 뷰가 제거되었음을 알려준다.  
 
</br>
<hr>
 
## Reference  

- https://zeddios.tistory.com/43
- https://medium.com/ios-development-with-swift/앱-생명주기-app-lifecycle-vs-뷰-생명주기-view-lifecycle-in-ios-336ae00d1855 
- https://www.edwith.org





