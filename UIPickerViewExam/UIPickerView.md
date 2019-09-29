
# UIPickerView  

UIPickerView의 필수적인 Delegate 와 DataSource의 메서드 사용법들을 정리하겠습니다.  


- `UIPickerViewDataSource` : PickerView의 데이터를 설정한다.
- `UIPickerViewDelegate` : PickerView의 다양한 이벤트를 처리한다.


## UIPickerView Basic  

```swift

class ViewController: UIViewController {
    
    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        
        picker.frame = CGRect(x: 0, y: self.view.bounds.size.height / 3 , width: self.view.bounds.size.width, height: 180.0)
        
        picker.backgroundColor = UIColor.white
        
        picker.delegate = self
        picker.dataSource = self
        
        return picker
    }()
    
    // private let pickerView = UIPickerView()
    private var pickerData1: [String] = ["A","B","C","D","E","F","G","H","I"]
    private var pickerData2: [String] = ["a","b","c","d","e","f","g","h","i"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(pickerView)
        
    }
    
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    // pickerView의 열의 개수를 반환한다
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    // 하나의 Component당 data의 개수를 설정한다.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData1.count
    }
    
    // picker가 선택이 되었으면 호출되는 callback method
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("row: \(row)")
        print("value: \(pickerData1[row])")
        print("row: \(row)")
        print("value: \(pickerData2[row])")
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return pickerData1[row]
        } else {
            return pickerData2[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        
        // 위에서 설정한 selectedRow의 Component에 따라 컨텐츠르 다르게 보여주는 작업을 한다.
        if component == 0 {
            pickerLabel.text =  "왼쪽" + pickerData1[row]
        } else {
            pickerLabel.text = pickerData2[row] + "오른쪽"
        }
        
        pickerLabel.font = UIFont(name: "Apple Color Emoji", size: 20)
        // 중앙 정렬
        pickerLabel.textAlignment = NSTextAlignment.center
        
        return pickerLabel
    }
    
    
}
```


- PickerView의 열의 개수 즉 Component의 개수를 설정하는 메서드

```swift
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2	// pickerView에 2개의 열이 생성된다.
    }
```    

- PickerView의 행의 개수를 설정한다.(보통 PickerView에 담기는 Sequence나 collection의 count를 반환하도록한다)
```swift
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count // pickerData배열의 컨텐츠 개수
    }
```  

- PickerView의 이벤트를 감지하여 선택된 row 값을 알 수 있다  

```swift
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            print("row: \(row)")
            print("value: \(pickerData1[row])")
        } else {
            print("row: \(row)")
            print("value: \(pickerData2[row])")
        }
    }
```  

- PickerView에서 row의 title을 설정하는 메서드이다. 메서드를 보면 String 반환 타입이기때문에 단순하게 행의 text가 될 String을 반환 해주는 함수이다.  

```swift
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return pickerData1[row]
        } else {
            return pickerData2[row]
        }
    }
```  

- PickerView에서 row의 View를 설정할 수 있는 함수이다. UIView를 return 하기 때문에 아래와 같이 UILabel을 리턴 할 수 있다.
```swift
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        
        // 위에서 설정한 selectedRow의 Component에 따라 컨텐츠르 다르게 보여주는 작업을 한다.
        if component == 0 {
            pickerLabel.text =  "왼쪽" + pickerData1[row]
        } else {
            pickerLabel.text = pickerData2[row] + "오른쪽"
        }
        
        pickerLabel.font = UIFont(name: "Apple Color Emoji", size: 20)
        // 중앙 정렬
        pickerLabel.textAlignment = NSTextAlignment.center
        
        return pickerLabel
    }
```     

<img width="582" alt="image" src="https://user-images.githubusercontent.com/33486820/65815456-b124e600-e22a-11e9-840b-194112127178.png">



- `pickerView(viewForRow:)`메서드에서 `UIImageView` 반환 테스트  

```swift
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerImageView = UIImageView()

        pickerImageView.image = UIImage(named: "myFace")
        return pickerImageView
    }
```

위의 코드를 실행하면 Row의 height 크기가 default값으로 매우 작아 imageView를 볼 수없다. height와 width를 수정할 수 있는 delegate 메서드는 아래의 두개이다.  
- `pickerView(rowHeightForComponent:)`  

```swift
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 200.0
    }
    
```  
- `pickerView(rowWidthForComponent:)`

```swift
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 200.0
    }
```


아래와 같이 얼굴이 나오는 걸 확인 할 수 있다.

<img width="582" alt="image" src="https://user-images.githubusercontent.com/33486820/65815401-d7965180-e229-11e9-8f71-1e47af3aa1d8.png">  


<hr>

<br>

## Reference  

- Apple Developer - UIPickerView
	- [UIPickerViewDelegate](https://developer.apple.com/documentation/uikit/uipickerviewdelegate)
    - [UIPickerViewDataSource](https://developer.apple.com/documentation/uikit/uipickerviewdatasource)

