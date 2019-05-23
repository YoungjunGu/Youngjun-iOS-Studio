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
    
</br>
    
### 메모리 누수가 발생하는 상황  

`ViewController`가 dealloc이 된다고 가정  


