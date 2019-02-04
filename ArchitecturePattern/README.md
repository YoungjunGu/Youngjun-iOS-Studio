# Architecture Pattern

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

> Apple의 MVC 

<img width="748" alt="2019-02-04 2 29 11" src="https://user-images.githubusercontent.com/33486820/52200240-940e6200-28ab-11e9-9c8f-dc201d20e4e9.png">

Controller 는 Model 과 View 를 연결 시켜주는 역할이기 때문에 서로에 대해 자세한 사항을 알 필요 없다. 그 중에서 재사용이 불가능한 것이 Controller 이다. 모든 특이한 로직을 Model 이 아닌 Controller에 넣어야 한다.
문제점:  뷰 컨트롤러 덩어리 ( Massive View Controller)


> 실제  Appler의 MVC






