# Architecture Pattern

많은 사람들과 협업을 진행할때 Architecture Pattern의 중요성을 매우 강조하고 있습니다. 그렇기 때문에 Architecture Pattern 을 공부하고 앞으로의 프로젝트에 적극 활용하기 위해 정리를 하겠습니다.

이 글은 아래 글과 강의를 바탕으로 정리 한 내용입니다.

[iOS Architecture Pattern](https://medium.com/ios-os-x-development/ios-architecture-patterns-ecba4c38de52)
<br>
[Edwith MVC Pattern](https://www.edwith.org/swiftapp/lecture/26620/)


<hr>

> 아키텍쳐 패턴이 필요한 이유?

많은 양의 클래스를 디버깅하고 또 비교 할때 어떤 버그나 에러를 찾지 못한다. 클래스의 모든 속성을 머리로 기억 할 수 없기 때문에 세부적인 사항을 놓치게 된다. 

- 클래스가 UIViewController의 자식 클래스
- 데이터들이 UIViewController에서 바로 저장
- UIView 가 일을 거의 하지 않음
- Model이 빈 데이터 구조
- Unit test 로 아무것도 하지 않음

> 좋은 아키텍쳐의 특징
- 엄격한 룰에 따른 개채간의 책임 분리(Distribution)
- 첫번째 특징에서의 테스트들이 가능 (Testability)
- 사용하기 편하다 -> 유지 보수 용이     (Ease of use)

> 분리 하는 이유는?

분배 후 처리시 각 작업에 대해 균등하게 분담
각각의 분리된 하나의 책임 단위로 수많은 개체들의 책임을 쪼개어서 분담하는 것이 특징 중 하나

> 그럼 왜 테스트 가능해야 하는가?

새 기능을 추가, 클래스의 몇몇 복잡성을 리팩토링 하기 위해서 , 문제가 발생하면 이것을 해결하기에는 너무 많은 시간이 걸린다. 순간순간 테스트들이 가능해야하는지를 확인 해야한다

> 왜 사용하기 쉬워야 하는지?

“코드가 적은 양일 수록 버그가 적다”
클린 코드를 실천해야하는 것이 하나의 과제
유지 보수에 용이 하다는 것

### 필수 MV(x)

- MVC
- MVP
- MVVM
- VIPER

MVC MVP MVVM 는 3개 카테고리 중 하나는 포함

- Models - 데이터나 데이터 접근 레이어(Person 클래스나 PersonDataProvider 클래스와 같이 데이터를 다루고 있는) 소유를 책임지는 부분
- Views - 레이어에 표현되 있는 것을 책임지는 부분(GUI) , iOS 환경에서는 UI가 접두사로 붙는다
- Controller/Presenter/ViewModel - Model 과 View를 붙여주는 역할, 보통 유저가 View에서 어떤 액션을 취할때 Model 을 변경하거나 Model이 변경 되었을 때 , View 를 갱신하는 책임을 가지는 부분

> 개채들이 하는 일을 분할 할때의 장점

- 이해하는 것이 쉽다
- 재사용(Reusable) 이 가능하다(View, Model 적용가능)
- 독립적으로 테스트가 가능하다

## MVC 

> 기존의 MVC 모델의 사용

<img width="730" alt="2019-02-04 2 24 55" src="https://user-images.githubusercontent.com/33486820/52200191-6f19ef00-28ab-11e9-8d60-b63b5f9098ff.png">

기존의 MVC 모델의 문제점은 View 의 범위가 정확하지 않다. Model이 변경 되면 Controller 에 의해 Update위해 렌더링 된다. 위의 구조를 보면 알 수 있듯이 각 개체 들은 남은 개체 들에대해 존재를 알고 있고 서로에게영향을 주게 된다. 이것은 재사용성을 줄이게 된다.

> Apple이 제시한 Cocoa MVC 

<img width="748" alt="2019-02-04 2 29 11" src="https://user-images.githubusercontent.com/33486820/52200240-940e6200-28ab-11e9-9c8f-dc201d20e4e9.png">

Controller 는 Model 과 View 를 연결 시켜주는 역할이기 때문에 서로에 대해 자세한 사항을 알 필요 없다. 그 중에서 재사용이 불가능한 것이 Controller 이다. 모든 특이한 로직을 Model 이 아닌 Controller에 넣어야 한다.
위의 Cocoa MVC는 Model 과 View 의 독립성이 보장 된다. 하지만 실제 개발 과정에서느 조금 다르다

> 실제  Appler의 MVC

<img width="743" alt="2019-02-04 2 38 28" src="https://user-images.githubusercontent.com/33486820/52202530-0da94e80-28b2-11e9-9dfd-6748f43b0d13.png">

UIViewController는 View 를 소유하게 되고 View 들의 Life Cycle과 강하게 연결 된다. 그렇게 되면 View 와 Controller의 분리가 쉽지 않고 결국 종속 되어 버린다. 그렇게 되면 Controller와 View 의 재사용성이 떨어진다. 이렇게 View 와 Controller가 강하게 연결되어 있으면 Testing 이 어려워 진다. 그리고 View 
위에서의 사용자의 Action 과 이에 따른 Method 뿐만 아니라 UIViewController 에서 일어나는 각종 행위로 (네트워크 통신, Delegagtion 등) Controller는 방대해지는데 이를 Massive View Controller 라고 부르기도 한다.

위의 다이어그램에서 View 와 Controller가 뭉쳐져 방대해진 UIViewController 의 사이즈를 줄이는 행위, [View Controller Offloading](https://www.objc.io/issues/1-view-controllers/lighter-view-controllers/) 가 하나의 이슈이다.


```swift
import UIKit
import PlaygroundSupport


struct Person { //Model
    let firstName: String
    let lastName: String
}


class GreetingViewController: UIViewController { //View + Controller
    var person: Person!
    
    lazy var showGreetingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Click", for: .normal)
        button.addTarget(self, action: #selector(didTapButton(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var greetingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)
        self.setupLayout()
    }
    
    // Layout codes in Controller
    func setupLayout() {
        self.setupButton()
        self.setupLabel()
    }
    
    private func setupButton() {
        self.view.addSubview(showGreetingButton)
        showGreetingButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        showGreetingButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    private func setupLabel() {
        self.view.addSubview(greetingLabel)
        greetingLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        greetingLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30).isActive = true
    }
    
    @objc func didTapButton(sender: UIButton) {
        let greeting = "My name is " + " " + self.person.firstName + " " + self.person.lastName
        self.greetingLabel.text = greeting
    }
   
}


// Assembling of MVC
let model = Person(firstName: "Gu", lastName: "Young Jun")
let vc = GreetingViewController()
vc.person = model

PlaygroundPage.current.liveView = vc.view
```

예제 코드를 살펴 보며 왜 View와 Controller 가 강하게 연결 되어있는지 알 수 있다. GreetingViewController 안에 View 의 생성과 배치에 관련된 코드들(UILabel, UIButton,ViewFrame 등,,) 이 위치하게 되고 갱신 또한 Controller 안에서 이루어지는 것을 확인 할 수 있다.

앞서 언급한 View 의 테스팅 과정 또한 Controller 안에서 View Life Cycle 과 관련된 메소드 (`viewDidLoad`, `viewWillApear` 등) 의 호출이 없으면 안되기 때문에 역시 강하게 연결 되어있는 것을 확인 가능하다.

> MVC 아키텍쳐는 3가지 키워드에 부합 하는 아키텍쳐인가?

- **Distribution**(분리): View 와 Model을 분리( Person Model, GreetingViewController), 하지만 View 와 Controller는 강하게 연결 되어 있다.
- **Testability**(테스트가능성): View와 Controller가 강하게 연결 되어 있기 때문에 Model만 테스팅을 진행 할수 있다.
- **Easy of Use**(손쉬운 사용): 가장 기본적은 아키텍쳐 패턴이고 다른 아키텍쳐에 비해 코드의 양이 훨씬 적어서 쉽게 유지보수가 가능하다(앞으로 다른 모델들과 비교)

MVC는 iOS 개발시 가장 간단한 아키텍쳐 모델 이고 쉬운 패턴입니다. 하지마 앞서 말했듯이 유지보수에 상당히 많은 비용을 투자해야한다는 단점이 있다.

<hr>

## MVP

- **M**odel
- **V**iew(`UIView` and/or `UIViewController`)
- **P**resenter

![image](https://user-images.githubusercontent.com/33486820/52329165-550c1800-2a35-11e9-8b49-a8861f3bcaa6.png)

위의 MVP 다이어그램은 구조가 MVC 와 매우 유사하다. 
`UIView` 와 `UIViewController` 가 모두 View에 해당된다. Cocoa MVC 와의 차이점은  `UIViewController`는 Controller에 해당 했고 View 와 서로 합쳐진 형태로 강하게 의존하고 있느 형태이다. 그러므로 View Life Cycle 에 영양을 미치는 반면 MVP 에서는 중간 역할을 하는 **Presenter** 가 존재하고 이는 아무런
영향을 끼치지 않는다.
또한 Presenter는 Layout 코드가 존재 하지 않고 Contoller의 역할에 보다 충실하게 View를 데이터와 상태에 맞추어 갱신하는 역할을 한다.
**즉 Presenter는 Model로 부터 갱신된 데이터를 받아오 뷰를 갱신하는 역할을 한다**

> UIViewController 가 View인가?

MVP에서는 UIViewController의 자식클래스에 Presenter(Controller)가 아닌 View에 해당한다. 이는 보다 테스팅의 효과를 높일 수 있지만 수작업의 데이터나 이벤트 바인딩을 따로 만들어야 하느 추가적인 비용이 발생한다 예제를 통해 확인해보자.

```swift
import UIKit
import PlaygroundSupport

struct Person { // Model
    let firstName:String
    let lastName:String
}

protocol GreetingView:class { // View Protocol
    func setGreeting(greeting:String)
}

protocol GreetingViewPresenter { // Presenter Protocol
    init(view: GreetingView, person: Person)
    func showGreeting()
}

class GreetingPresenter : GreetingViewPresenter { // Presenter
    weak var view: GreetingView?
    let person: Person

    required init(view: GreetingView, person: Person) {
        self.view = view
        self.person = person
    }
    // 3.
    func showGreeting() { // Update View
        let greeting = "Hello" + " " + self.person.firstName + " " + self.person.lastName
        self.view?.setGreeting(greeting: greeting)
    }
}

class GreetingViewController : UIViewController, GreetingView { // View
    var presenter: GreetingViewPresenter!
    ...
    // Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)
        setupLayout()
        self.showGreetingButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    ...
    // Layout Code
    // 2. 
    @objc func didTapButton(button: UIButton) {
        self.presenter.showGreeting()  // Send Action to Presenter
    }
    // 1.
    func setGreeting(greeting: String) {
        self.greetingLabel.text = greeting
    }
    // layout code goes here
}
// Present the view controller in the Live View window
// Assembling of MVP
let model = Person(firstName: "Gu", lastName: "Youngjun")
let view = GreetingViewController()
let presenter = GreetingPresenter(view: view, person: model)
view.presenter = presenter

PlaygroundPage.current.liveView = view
```






























