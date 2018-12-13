//
//  RegisterVC.swift
//  MessageApp
//
//  Created by user146304 on 12/7/18.
//  Copyright © 2018 Voflic. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterVC: UIViewController {

    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //Mukil**Just add email and password(pass should have 6 leter) to database
    @IBAction func registerPressed(_ sender: Any) {
        SVProgressHUD.show()
        
        Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (user, error) in
            if error != nil{
                print(error!)
            }else{
                //printing the masage in the xcode
                print("Registeration Successful")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        }
    }
}
