//
//  SignInVC.swift
//  InstaCloneParse
//
//  Created by Volkan on 31.12.2019.
//  Copyright © 2019 Volkan. All rights reserved.
//

import UIKit
import Parse

class SignInVC: UIViewController {

    
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func signInClicked(_ sender: Any) {
        
        if userNameText.text! != nil && passwordText.text! != nil {
            PFUser.logInWithUsername(inBackground: userNameText.text!, password: passwordText.text!) { (user, error) in
                if error != nil {
                    self.makeAlert(titleInput: "ERROR!", messageInput: error?.localizedDescription ?? "Error")
                }else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        }else {
            makeAlert(titleInput: "ERROR!", messageInput: "Username/Password??")
        }
        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if userNameText.text! != "" && passwordText.text! != "" {

        let user = PFUser()
        user.username = userNameText.text!
        user.password = passwordText.text!
            user.signUpInBackground { (success, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                }else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        
        }else {
            makeAlert(titleInput: "ERROR!", messageInput: "SignUp Error!")
        }
        
    }
    func makeAlert(titleInput : String , messageInput : String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    

}
