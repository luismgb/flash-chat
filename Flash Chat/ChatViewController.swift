//
//  ViewController.swift
//  Flash Chat
//
//  Created by Luis M Gonzalez on 1/24/18.
//  Copyright © 2018 Luis M Gonzalez. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  
  
  // Declare instance variables here
  
  
  // We've pre-linked the IBOutlets
  @IBOutlet var heightConstraint: NSLayoutConstraint!
  @IBOutlet var sendButton: UIButton!
  @IBOutlet var messageTextField: UITextField!
  @IBOutlet var messageTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    messageTableView.delegate = self
    messageTableView.dataSource = self
    
    
    //TODO: Set yourself as the delegate of the text field here:
    
    
    
    //TODO: Set the tapGesture here:
    
    
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
  
  
  //TODO: Declare tableViewTapped here:

  
  
  func configureTableView() {
    messageTableView.rowHeight = UITableViewAutomaticDimension
    messageTableView.estimatedRowHeight = 120
  }
  
  
  ///////////////////////////////////////////
  
  //MARK:- TextField Delegate Methods
  
  
  
  
  //TODO: Declare textFieldDidBeginEditing here:
  
  
  
  
  //TODO: Declare textFieldDidEndEditing here:
  
  
  
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
