//
//  LoginViewController.swift
//  
//
//  Created by youngjun goo on 27/01/2019.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    //firebase의 내용을 원격으로 가져옴
    let remoteConfig = RemoteConfig.remoteConfig()
    var colorString: String! = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let stateBar = UIView()
        self.view.addSubview(stateBar)
        stateBar.snp.makeConstraints{ (m) in
            m.right.top.left.equalTo(self.view)
            m.height.equalTo(20)
        }
        colorString = remoteConfig["splash_background"].stringValue
        
        stateBar.backgroundColor = UIColor(named: colorString)
        loginButton.backgroundColor = UIColor(hex: colorString)
        signInButton.backgroundColor = UIColor(hex: colorString)
        
        //button action 연결
        signInButton.addTarget(self, action: #selector(signUpPresent), for: .touchUpInside)
        
    }
    
    @objc func signUpPresent() {
        let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignUpViewController
        self.present(signUpVC, animated: true, completion: nil)
    }
    
}
