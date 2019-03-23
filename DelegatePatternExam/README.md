# Delegate Pattern

## Delegate란 ?

> Delegate : "대리자", "위임자"

**Delegate pattern** 은 객체지향 프로그래밍에서 하나의 객체가 모든 일을 처리하는 것이 아니라 처리 해야할 일 중 일부를 다른 객체에 위임하는 것을 뜻한다.

델리게이션 패턴은 하나의 프르토콜과 두가지의 객체로 나뉜다.

- protocol: 해야할 작업의 목록
- sender: task 처리를 요청할(위임)할 객체
- receiver: 위임받은 task를 처리하는 객체

## Example

> 댓글을 달기 위해 UIView에다가 사용자가 댓글을 입력한 후 버튼을 누르면 Controller는 commentView가 어떤 버튼 이벤트가 발생했는지 체크하고 해당 처리를 진행하는 예제를 해보자

- 처리를 위임하는 입장의 CommentView 객체

```swift
import UIKit

protocol CommentViewDelegate: class {
    func touchUpCommentButton()
}

class CommentView: UIView {
    
    weak var delegate: CommentViewDelegate?
    var commentButton: UIButton?
    var commentTextField: UITextField?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    func configure() {
        commentButton = UIButton(type: .system)
        if let button = commentButton {
            button.setTitle("comment", for: .normal)
            button.sizeToFit()
            button.frame.origin = CGPoint(x: (self.bounds.width - button.bounds.width) * 0.5,
                                       y: (self.bounds.height - button.bounds.height) * 0.5)
            button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
            self.addSubview(button)
        }
        commentTextField = UITextField()
        if let textField = commentTextField {
            textField.sizeToFit()
            textField.frame.origin = CGPoint(x: (self.bounds.width - textField.bounds.width) * 0.5,
                                             y: (self.bounds.height - textField.bounds.height) * 0.5)
            
            self.addSubview(textField)
        }
    }
    @objc func tapButton() {
        delegate?.touchUpCommentButton()
    }
}
```

프로토콜 프로터니는 위임 받은 객체를 저장해둘 프로퍼티이다.

```swift
 weak var delegate: CommentBoxDelegate?
```

- Controller에서 처리를 위임 받아 수행

```swift
import UIKit

class ViewController: UIViewController {
    
    var commentView: CommentView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        commentView = CommentView(frame: CGRect(origin: .zero, size: CGSize(width: 300, height: 200)))
        if let commentView = commentView {
            commentView.frame.origin = CGPoint(x: (UIScreen.main.bounds.width - commentView.bounds.width) * 0.5, y: (UIScreen.main.bounds.height - commentView.bounds.height) * 0.5)
            
            commentView.backgroundColor = UIColor.lightGray
            commentView.delegate = self
        }
    }


}

extension ViewController: CommentViewDelegate {
    func touchUpCommentButton() {
        print("touchButton")
    }

}
```

## UITableView의 Delegate & DataSource

UITableView에서 테이블 뷰 관련하야 처리를 위한 두개의 델리게이트 프로토콜이 존재한다.

- `UITableViewDataSource`

```swift
extension TableViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView,
                  numberOfRowsInSection section: Int) -> Int {
    return self.items.count
  }

  func tableView(_ tableView: UITableView,
                  cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell = tableView.dequeueReusableCell
                    (withIdentifier: "TableViewCell")! as UITableViewCell

    cell.textLabel?.text = items[indexPath.row]

    return cell
  }
}
```

- `UITableViewDelegate`


```swift
extension TableViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(items[indexPath.row])
  }
}
```

UITableView의 델리게이트 프로토콜을 채택할 경우 필수적으로 구현해야하는것이 Table의 Section의 개수 반환함수, 그리고 Table의 Cell에 관한 설정을 하는 함수 이렇게 두가지를 반드시 구현해야한다.


구현한 후 반드시 처리하라고 위임하는 객체에 해당 델리게이트 객체를 넣어주는 작업을 해야한다.

- Delegating이 일어나는 부분

```swift
self.myTableView.dataSource = self
self.myTableView.delegate = self
```

전체 적으로 진행을 요약하자면

1. Deleagte Protocol을 구현 
2. 위임받아 처리할 곳에서 Delegate 객체를 선언
3. delegate 객체를 넣는 작업


## 사용하는 이유


### 코드의 중복성을 줄일 수 있다.

앱 내의 댓글 서비스를 예를 들어보면 사용자는 단순하게 리뷰의 댓글을 남길 수 있고, 신고내용의 댓글, 추천(좋아요 싫어요), 대 댓글, 댓글 지우기 등등 댓글 기능을 써야하는 부분마다 쓰이는 내용과 용도가 다르면 해당 댓글 처리를 할때마다 객체를 넘겨서 처리를 해야하게 되고 이는 중복성을 발생시킵니다.

Delegate pattern 을 사용하게되면 댓글 기능은 대신 작업을 처리할 delegate 구현 객체에 대해서 따로 신경 쓰지 않고 위와 동일한 방식으로 Delegate 프로토콜 프로퍼티를 통해 작업을 위임하기만 하면된다.













