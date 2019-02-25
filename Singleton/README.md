# Singleton(싱글턴)

싱글턴은 'App Life Cycle 주기 동안 특정 클래스의 인스턴스가  오직 하나임을 보장하는 객체' 를 의미한다.
싱글턴은 애플리케이션이 요청한 횟수와는 관계없이 이미 생성된 같은 인스턴스를 반환한다. 이는 앱 내부의 모든 곳에서 공유될 수 있는 객체 자원이라고 할 수 있다. 애플리케이션 내에서 특정 클래스의 인스턴스가 딱 하나만 있기 때문에 다른 인스턴스 들이 공유해서 사용할 수 있다.

![image](https://user-images.githubusercontent.com/33486820/53337684-72057e00-3945-11e9-8d4c-dfd1c947ab09.png)

(위의 구조에서 알수 있듯이 오직 하나의 객체 A만 반환해주는 것을 알 수 있다.)

## Example

아래 예제에서 SingleTonClass의 인스턴스는 외부에서 그냥 생성 할 수 없고 오직 [`object`] 변수를 통해서만 접근 가능하다

```swift
class SingleTonClass {
	static let object = SingleTonClass()
    
    private init() {}
    
    func doSomething() {
    ...
    }
}
//접근방법
SingleTonClass.object.doSomething()
```

> 전역 변수로써 싱글턴

위와 같이 생성된 오직하나의 싱글턴 객체는 프로그램 전역에서 접근이 가능하다. 이러한 성질은 전역변수와 매우 비슷한 성질을 뛰게 된다.
프로그램내에서 어디든 제한없이 접근이 가능한 전역의 성질을 띄기 때문에 조심히 사용하여야 한다. 어디서든 접근이 가능해 쉽게 변경이 가능하고 또 다중의 전역변수가 존재 할 경우 이를 관리하는데 어렴움이 있을 뿐만 아니라 불필요한 메모리를 차지하는 문제점들이 있다.
<br>
싱글턴또한 마찬가지다.
<br>
우선 싱글턴 디자인 패턴은 불필요하게 객체가 중복되어 생성 되는 경우에 그런 중복성을 줄이기 위해 싱글턴 패턴을 사용한다.예를 들어 환경설정, 네트워크 연결처리, 데이터 관리 등의 상황에서 유용하다. 
Apple은 iOS 프레임워크 자체에서 싱글턴을 사용한 것을 볼수 있다.<br>

> Cocoa 프레임워크에서의 싱글턴 디자인 패턴

<br>

- `FileManager`: 애플리케이션 파일 시스템을 관리하는 클래스
	- `let defaultFileManager = FileManager.default`
    
<br>

- `URLSession`: URL 세션을 관리하는 클래스
	- `let sharedURLSession = URLSession.shared` 

<br>

- `NotificationCenter`: 등록된 알림의 정보를 사용할 수 있게 해주는 클래스
	- `let defaultNotiCenter = NotificationCenter.default`
    
<br>

- `UserDefaults`: Key-Value 형태로 간단한 데이터를 저장하고 관리할 수 있는 인터페이스를 제공하는 데이터베이스 클래스
	- `let standardUserDefault = UserDefaults.standard`
    
<br>

- `UIApplication`: iOS에서 실행되는 중앙제어 애플리케이션 객체
	- `let sharedUIApplication = UIApplication.shared`
    
<br>

(싱글턴 인스턴스를 반환하는 팩토리 메서드나 프로퍼티는 일반적으로 shared라는 이름을 사용한다)
싱글턴 패턴은 Cocoa 프레임워크에서도 찾아 볼 수 있었다. 위에서 지원하는 basic 한 작업 외에도 내가 필요하에 직접만들어서 사용이 가능하다 하지만 여기에는 장점과 단점이 존재한다.<br>


## Singleton 문제점

"싱글턴이 혁신적이다"라는 문구가 적힌 사이트는 볼 수 없었다 단지 메모리에서의 이점, 데이터 공유, 편리함제공 정도로만 장점을 들면서 반대로 싱들턴의 문제점을 많이들 지적했다. 

> 편리함을 위해 투명성을 희생

- "전역의 성질을 띄고 어디에서든지 접근해서 변경 할수 있다"

앞에서도 설명 했 듯이 어디서든 접근해 객체의 상태를 변경 시켜버릴 수 있기 때문에 해당 객체가 어떤 상태인지 예측하기란 힘들다. 그렇게 되면 Life Cycle을 관리하는 것 또한 힘들어 진다. 만약 싱글턴 클래스 내에서 싱글턴 객체가 변경이 되거나 옵셔널한 값으로 반환이 되면 더욱 더 해당 싱글턴 객체의 상태를 예측하기는 힘들다.
<br>

- "개방-폐쇄 원칙 위배"

싱글턴 객체가 여러가지 작업을 모두 맡아서 일을 하거나 많은 데이터를 공유시킬 경우에 다른 클래스의 객체들 간에 결합도가 높아져 [`개방-폐쇄 원칙`](https://ko.wikipedia.org/wiki/개방-폐쇄_원칙)을 위배하게 된다. 따라서 수정과 테스트에 어려움을 겪는다.
<br>

- "Unit Test를 방해하는 싱글턴"

`let myObject = SingleTonClass.object` 에서 `myObject` 객채는 `SingleTonClass` 의 싱글턴 객체에 매우 강하게 의존한다. 이 둘의 관계는 매우 강하게 묶여 있고 해당 객체를 테스트 하기 위해서는 싱글턴 객체를 완벽하게 구현해주어야 한다. 만약 문제가 발생하면 테스트하기가 어려워 진다. 











