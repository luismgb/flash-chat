//
//  RegisterViewController.swift
//  Flash Chat
//
//  This is the View Controller which registers new users with Firebase
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
  
  
  @IBOutlet var emailTextfield: UITextField!
  @IBOutlet var passwordTextfield: UITextField!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
  @IBAction func registerPressed(_ sender: AnyObject) {
    Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
      if error != nil {
        //TODO: Tell user that there was an error creating account using HUD.
        print(error!)
      } else {
        print("Resgistration Successful")
        self.performSegue(withIdentifier: "goToChat", sender: self)
      }
    }
  }
  
  
}

