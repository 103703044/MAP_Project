//
//  login.swift
//  baseballRecord
//
//  Created by 賴昱榮 on 2017/11/24.
//  Copyright © 2017年 賴昱榮. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
var userUID = ""
class loginController: UIViewController{
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func createAccountButton(_ sender: Any) {
        FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error == nil{
                let alert = UIAlertController(title: "Success", message:"You have successfully signed up!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
                self.present(alert, animated: true){}
            }
            else {
                let alert = UIAlertController(title: "Error", message:error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
                self.present(alert, animated: true){}
            }
    }
}
    @IBAction func loginAction(_ sender: Any) {
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error == nil{
                userUID = (user?.uid)!
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "settingPage")
                self.present(vc!,animated: true,completion:nil)
            }
            else{
                let alert = UIAlertController(title: "Error", message:error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
                self.present(alert, animated: true){}
            }

    }
    }
    
}
