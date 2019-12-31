//
//  SettingsVC.swift
//  InstaCloneParse
//
//  Created by Volkan on 31.12.2019.
//  Copyright © 2019 Volkan. All rights reserved.
//

import UIKit
import Parse

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    @IBAction func logoutClicked(_ sender: Any) {
        PFUser.logOutInBackground { (error) in
            if error != nil {
                let alert = UIAlertController(title: "ERROR!", message: "Logout Error!", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else {
                self.performSegue(withIdentifier: "toSignInVC", sender: nil)
            }
        }
    }
    

}
