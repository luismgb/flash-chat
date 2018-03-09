//
//  ChatViewController.swift
//  Flash Chat
//
//  Created by Luis M Gonzalez on 1/24/18.
//  Copyright © 2018 Luis M Gonzalez. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
  
  var messageArray = [Message]()
  
  @IBOutlet var heightConstraint: NSLayoutConstraint!
  @IBOutlet var sendButton: UIButton!
  @IBOutlet var messageTextField: UITextField!
  @IBOutlet var messageTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    messageTextField.delegate = self
    
    messageTableView.delegate = self
    messageTableView.dataSource = self
    messageTableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tableViewTapped)))
    messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
    configureTableView()
    startMonitoringForMessages()
  }
  
  
  ///////////////////////////////////////////
  
  //MARK: - TableView DataSource Methods
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
    cell.messageBody.text = messageArray[indexPath.row].messageBody
    cell.senderUsername.text = messageArray[indexPath.row].sender
    cell.avatarImageView.image = UIImage(named: "egg")
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messageArray.count
  }
  
  @objc func tableViewTapped() {
    messageTextField.endEditing(true)
  }
  
  func configureTableView() {
    messageTableView.rowHeight = UITableViewAutomaticDimension
    messageTableView.estimatedRowHeight = 120
  }
  
  
  ///////////////////////////////////////////
  
  //MARK:- TextField Delegate Methods
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
  }
  
  @objc func keyboardWillShow(_ notification: Notification) {
    if let keyboardRectangle = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
      let keyboardHeight = keyboardRectangle.height
      UIView.animate(withDuration: 0.5) {
        if #available(iOS 11.0, *) {
          self.heightConstraint.constant = keyboardHeight - self.view.safeAreaInsets.bottom + 50
        } else {
          self.heightConstraint.constant = keyboardHeight + 50
        }
        self.view.layoutIfNeeded()
      }
      view.layoutIfNeeded()
    }
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    UIView.animate(withDuration: 0.2) {
      self.heightConstraint.constant = 50
      self.view.layoutIfNeeded()
    }
  }
  
  
  ///////////////////////////////////////////
  //MARK: - Send & Recieve from Firebase
  
  func startMonitoringForMessages() {
    let messageDB = Database.database().reference().child("Messages")
    messageDB.observe(.childAdded) { (snapshot) in
      let snapshotValue = snapshot.value as! [String: String]
      let text = snapshotValue["MessageBody"]!
      let sender = snapshotValue["Sender"]!
      let message = Message()
      message.messageBody = text
      message.sender = sender
      self.messageArray.append(message)
      self.configureTableView()
      self.messageTableView.reloadData()
    }
  }
  
  @IBAction func sendPressed(_ sender: AnyObject) {
    messageTextField.endEditing(true)
    messageTextField.isEnabled = false
    sendButton.isEnabled = false
    let messagesDB = Database.database().reference().child("Messages")
    let messageDictionary = ["Sender": Auth.auth().currentUser?.email, "MessageBody": messageTextField.text!]
    messagesDB.childByAutoId().setValue(messageDictionary) { (error, reference) in
      if error != nil {
        print(error!)
      } else {
        print("Message saved successfully")
        self.messageTextField.isEnabled = true
        self.sendButton.isEnabled = true
        self.messageTextField.text = ""
      }
    }
  }
  
  @IBAction func logOutPressed(_ sender: AnyObject) {
    do {
      try Auth.auth().signOut()
      navigationController?.popToRootViewController(animated: true)
    } catch {
      print("Signing out process failed")
    }
  }
  
  
  
}
