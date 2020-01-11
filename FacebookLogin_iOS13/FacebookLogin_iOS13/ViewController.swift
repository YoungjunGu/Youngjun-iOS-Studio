//
//  ViewController.swift
//  FacebookLogin_iOS13
//
//  Created by youngjun goo on 2020/01/10.
//  Copyright © 2020 youngjun goo. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tappedFaceBookLoginButton(_ sender: UIButton) {
        LoginManager().logIn(permissions: ["public_profile", "email", "user_birthday", "user_gender"], from: self, handler: { (result, error) in
            guard let result = result, error == nil && !result.isCancelled else {
                print("error: \(error)")
                // 로그인 취소/에러
                return
            }
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, email, picture, birthday, gender"]).start(completionHandler: { (connection, result, error) -> Void in
                print("error: \(error)")
                if (error != nil) {
                    // 로그인 에러
                    return
                }
                guard let facebook = result as? [String: AnyObject] else { return }

                let token = facebook["id"] as? String
                let name = facebook["name"] as? String
                let email = facebook["email"] as? String
                var profile = ""
                if let picture = facebook["picture"] as? [String: AnyObject], let data = picture["data"] as? [String: AnyObject] {
                    profile = data["url"] as? String ?? ""
                }
                let largeProfile = "https://graph.facebook.com/\((token ?? ""))/picture?type=large"
                let gender = facebook["gender"] as? String
                var birthdayDate: Date?
                if let birthday = facebook["birthday"] as? String, birthday != "" {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM/dd/yyyy"
                    birthdayDate = dateFormatter.date(from: birthday)
                }

                print("token: \(token)")
                print("name: \(name)")
                print("email: \(email)")
                print("profile: \(profile)")
                print("largeProfile: \(largeProfile)")
                print("gender: \(gender)")
                print("birthdayDate: \(birthdayDate)")
            })
        })
    }


}

