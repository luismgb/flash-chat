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
  }
  
  
  ///////////////////////////////////////////
  
  //MARK: - TableView DataSource Methods
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
    //TODO: Delete example messages for testing.
    let messageArray = ["First Message", "Second Message", "Third Message"]
    cell.messageBody.text = messageArray[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //TODO: Remove hard coded 3 used for testing.
    return 3
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
    UIView.animate(withDuration: 0.25) {
      self.heightConstraint.constant = 50
      self.view.layoutIfNeeded()
    }
  }
  

  
  ///////////////////////////////////////////
  
  
  //MARK: - Send & Recieve from Firebase
  
  
  
  
  
  @IBAction func sendPressed(_ sender: AnyObject) {
    
    
    //TODO: Send the message to Firebase and save it in our database
    
    
  }
  
  //TODO: Create the retrieveMessages method here:
  
  
  
  
  
  
  @IBAction func logOutPressed(_ sender: AnyObject) {
    do {
      try Auth.auth().signOut()
      navigationController?.popToRootViewController(animated: true)
    } catch {
      print("Signing out process failed")
    }
  }
  
  
  
}
