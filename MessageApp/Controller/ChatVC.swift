//
//  ChatVC.swift
//  MessageApp
//
//  Created by user146304 on 12/7/18.
//  Copyright © 2018 Voflic. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    //giving instance variabels here
    var messageArray : [Chat] = [Chat]()
    //We've pre-linked the IBOutlets
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatTextfield: UITextField!
    @IBOutlet weak var ChatTableView: UITableView!
    
    var topButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Mukil** set delegate to the table
        ChatTableView.delegate = self
        ChatTableView.dataSource = self
        ChatTableView.register(UINib(nibName: "ChatCell", bundle: nil) , forCellReuseIdentifier: "CustomChatCell")
        //Mukil** set delegate of text field
        chatTextfield.delegate = self
        
        //Mukil** set the tapGesturre Here
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chatViewTapped))
        ChatTableView.addGestureRecognizer(tapGesture)
        
        //Mukil** say that we have a separate cell created CustomChatCell.xid
        ChatTableView.register(UINib(nibName: "CustomChatCell", bundle: nil), forCellReuseIdentifier: "customChatCell")
        
        configureTableView()
        retrieveMessages()
        ChatTableView.separatorStyle = .none
    }
    //MARK: - logout button
    @IBAction func logOutPressed(_ sender: AnyObject) {
        do{
        try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }catch{
            print("error: there was a problem logging out")
//            self.performSegue(withIdentifier: "goToChat", sender: self)
        }
    }
    //MARK:- send pressed
    @IBAction func sendPressed(_ sender: AnyObject) {
        chatTextfield.endEditing(true)
        //Mukilan** send the message to firebase and save it in our database
        chatTextfield.isEnabled = false
        sendButton.isEnabled = false
        
        let messageDB = Database.database().reference().child("Message")
        let messageDictionary = ["Sender": Auth.auth().currentUser?.email, "MessageBody": chatTextfield.text!]
        messageDB.childByAutoId().setValue(messageDictionary){
            (error, reference) in
            if error != nil{
                print(error!)
            }else{
                print("Message saved sucess")
            }
            self.chatTextfield.isEnabled = true
            self.sendButton.isEnabled = true
            self.chatTextfield.text = ""
        }
    }
    //todo: create the retrieveMessages method here
    func retrieveMessages(){
        let messageDB = Database.database().reference().child("Messages")
        messageDB.observe(.childAdded, with: { (snaphsot) in
            let snaphsotValue = snaphsot.value as! Dictionary<String,String>
            let text = snaphsotValue["MessageBody"]!
            let sender = snaphsotValue["Snder"]!
            let message = Chat()
            message.messageBody = text
            message.sender = sender
            self.messageArray.append(message)
            self.configureTableView()
            self.ChatTableView.reloadData()
            
        })
    }
    
    //MARK:-  declare textfield begin editing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            //self.heightConstraint.constant = 308
            self.view.layoutIfNeeded()
        }
    }
    //Mukil** declare textfield end editign
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            //self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
    }
    //MARK: - Table View delegate number of cell in the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    //Mukil** cell for row at indexpath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customChatCell", for: indexPath) as! CustomChatCell
        
        cell.chat.text = messageArray[indexPath.row].messageBody
        cell.uName.text = messageArray[indexPath.row].sender
        cell.uImage.image = UIImage(named: "egg")
        if cell.uName.text == Auth.auth().currentUser?.email! {
            //set background to blue if message is from logged in user.
            cell.uImage.backgroundColor = UIColor.flatMint()
            cell.ChatBG.backgroundColor = UIColor.flatSkyBlue()
        }else{
            //set background to grey if message is from another user.
            cell.uImage.backgroundColor = UIColor.flatWatermelon()
            cell.ChatBG.backgroundColor = UIColor.flatGray()
        }
        
        return cell
    }
    
    //TODO: - say that we have a separate cell created hight and with
    func configureTableView(){
        ChatTableView.rowHeight = UITableView.automaticDimension
        ChatTableView.estimatedRowHeight = 120.0
    }
    
    //TODO: - declare talbeviewtapped
    @objc func chatViewTapped(){
        chatTextfield.endEditing(true)
    }
    
}
