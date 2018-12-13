//
//  LogIn.swift
//  MessageApp
//
//  Created by user146304 on 12/7/18.
//  Copyright © 2018 Voflic. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LogInVC: UIViewController {

    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //Mukil**login button
    @IBAction func logInPress(_ sender: AnyObject) {
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (user, error) in
            if error != nil{
                print(error!)
            }else{
                print("Log in Successful!")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        }
    }
}
