//
//  SignInViewController.swift
//  GroupTalk
//
//  Created by youngjun goo on 27/01/2019.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBAction func signUpAction(_ sender: Any) {
        doSignUp()
    }
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    let remoteConfig = RemoteConfig.remoteConfig()
    var colorString: String! = nil
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        
        setUpLayout()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func setUpLayout() {
        let statusBar = UIView()
        self.view.addSubview(statusBar)
        statusBar.snp.makeConstraints{ (m) in
            m.right.top.left.equalTo(self.view)
            m.height.equalTo(20)
        }
        colorString = remoteConfig["splash_background"].stringValue
        statusBar.backgroundColor = UIColor(hex: colorString)
        signUpButton.backgroundColor = UIColor(hex: colorString)
        cancelButton.backgroundColor = UIColor(hex: colorString)
    }
    
}

extension SignInViewController {
    
    func showAlert(message: String) {
        
        let alert = UIAlertController(title: "회원가입 실패", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    func doSignUp() {
        
        if emailTextField.text! == "" {
            showAlert(message: "이메일을 입력해주세요.")
            return
        }
        
        if pwdTextField.text! == "" {
            showAlert(message: "비밀 번호를 입력해 주세요.")
        }
        
        if nameTextField.text! == "" {
            showAlert(message: "이름을 입력해 주세요.")
        }
        
        signUp(email: emailTextField.text!, password: pwdTextField.text!, name: nameTextField.text!)
    }
    
    func signUp(email: String, password: String, name: String) {
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                
                if let ErrorCode = AuthErrorCode(rawValue: (error?._code)!) {
                    
                    switch ErrorCode {
                        
                    case AuthErrorCode.invalidEmail:
                        self.showAlert(message: "유효하지 않은 이메일 입니다.")
                    case AuthErrorCode.emailAlreadyInUse:
                        self.showAlert(message: "이미 가입한 회원 입니다.")
                    case AuthErrorCode.weakPassword:
                        self.showAlert(message: "비밀번호는 최소 6자리 이상 입니다.")
                    default:
                        print(ErrorCode)
                    }
                }
            } else {
                print("회원가입 성공")
                dump(user)
            }
        })
    }
    
    
}
