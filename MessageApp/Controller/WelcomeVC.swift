//
//  ViewController.swift
//  MessageApp
//
//  Created by user146304 on 12/7/18.
//  Copyright © 2018 Voflic. All rights reserved.
//

import UIKit
import Firebase

class WelcomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "goToChat", sender: self)
        }
    }


}

