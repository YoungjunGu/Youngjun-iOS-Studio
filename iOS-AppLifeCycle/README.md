# App Life Cycle(생명주기)  

앱 생명 주기는 크게 두가지 상태등을 정의해 놓은 일종의 "앱이 실행이 되었다가 사라지는" 하나의 과정이라고 할 수 있다.  

- background 상태: 홈버튼,전화 등 앱이 화면상에서 보이지 않는 상태
- foreground 상태: 화면에 앱이 올려져있는 상태  

## Swift의 앱 실행 

- `UIApplication` 객체 생성  
	싱글톤 객체로 Event Loop에서 발생하는 여러 이벤트 들을 감지하고 Delegate에 전달하는 역할을 한다. 예를 들어 앱이 백그라운드로 갈때, 메모리 부족 경고를 할 때와 같은 상황들을 감지하여 Delegate에 전달한다.  
    
- `@UIApplicationMain` 어노테이션이 있는 클래스를 찾아 `AppDelegate` 객체를 생성  
	AppDelegate 객체는 UIApplication 객체로 부터 메시지를 받았을 때, 해당 상황에서 실행 될 함수들을 정의한다.(`@UIApplicationMain` 어노테이션에 의해 AppDeleage.swift 파일 자체가 객체가 된다) 
    
<img width="321" alt="image" src="https://user-images.githubusercontent.com/33486820/58061834-d9347680-7bb2-11e9-875a-862b1820b9eb.png">  

- `Main Event Loop`를(touch, text input 등 유저의 액션을 받는 루프) 실행 및 기타 설정




