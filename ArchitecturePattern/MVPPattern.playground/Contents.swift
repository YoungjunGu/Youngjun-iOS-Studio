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

// Assembling of MVP
let model = Person(firstName: "Gu", lastName: "Youngjun")
let view = GreetingViewController()
let presenter = GreetingPresenter(view: view, person: model)
view.presenter = presenter

PlaygroundPage.current.liveView = view
