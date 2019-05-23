# IBOutlet

## IBOutlet을 Strong으로 연결  

<img width="863" alt="image" src="https://user-images.githubusercontent.com/33486820/58239064-56aee100-7d83-11e9-976b-6c62a2aef43d.png">  

#### Reference Count 계산

- `ViewController`가 `Strong`으로 myView를 소유  
	myView : 1
- `Interface Builder`에서 myView가 myLabel을 `subView`로 소유  
	myView: 1, myLabel: 1
- 코드에서 `VieController`가 `Strong`으로 myLabel을 소유하므로  
	myView: 1, myLabel: 2  
    
    <img width="363" alt="image" src="https://user-images.githubusercontent.com/33486820/58254538-f1b8b280-7da5-11e9-8127-b11b1d095d5f.png">

    
</br>
    
### 메모리 누수가 발생하는 상황  

`ViewController`가 dealloc이 된다고 가정  

- myView의 Reference Count를 감소(0이되므로) => myView가 메모리에서 해제
-  ViewController,myView가 메모리에서 해제 되므로 myLabel의 Reference Count를 감소(-2) => myLabel이 메모리에서 해제  

그렇게 되면 ViewController, View, Label 모두 아무런 문제 없이 모두 dealloc이된다.  
이처럼 Strong 이 결코 반드시 쓰면 안되는 것은 아니다.  
깊이가 깊은 View Hierarchy 구조에서 모든 Connection이 Weak라고 하면 구조의 중간 어디쯤에 있는 View가 갑작스럽게 dealloc이 된다면 그 하위 뷰들도 함께 dealloc이 된다.  


### 메모리 부족에 의해 Weak을 지향  

Default 값이 Weak인 이유는 Weak이 유리한 상황 또한 존재한다.  
바로 **메모리 부족**상황이다.  
메모리가 부족하면 ViewController의 `didReceiveMemoryWarning()` 메서드가 호출된다.  
`didReceiveMemoryWarning()`에서는 main view를 `nil` 처리함으로써 main view를 포함한 subview들 까지 모두 dealloc하여 메모리를 확보하는 동작을 구현한다.  

메모리가 부족한 상황에서 `IBOutlet` 들을 ViewController가 Strong 으로 참조하고 있다면 RC의 값이 1로 내려가지않아 SubView의 ParentView가 nil이 되더라도 SubView는 dealloc이 되지 않게되고, 보이지도 않는 뷰가 메모리를 차지하게 되는 상황이 벌어진다.  

> 결론: 메모리 부족현상을 대비하여 Weak를 사용하는 것이 좋다. 그리고 Strong의 경우 깊이가 깊은 복잡한 뷰 구조에서 특별한 경우에만 사용한다.  

</br>
<hr>

## Reference  

- http://monibu1548.github.io/2018/05/03/iboutlet-strong-weak/







