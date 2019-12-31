//
//  CellFeed.swift
//  InstaCloneParse
//
//  Created by Volkan on 31.12.2019.
//  Copyright © 2019 Volkan. All rights reserved.
//

import UIKit
import Parse

class MyCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var uuidLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func likeClicked(_ sender: Any) {
        let likeObject = PFObject(className: "Likes")
        likeObject["from"] = PFUser.current()?.username
        likeObject["to"] = uuidLabel.text
        
        likeObject.saveInBackground { (success, error) in
            if error != nil {
                self.makeAlert(titleInput: "ERROR!", messageInput: error?.localizedDescription ?? "ERROR!")
            }else {
                
            }
        }
    }
    
    @IBAction func commentButtonClicked(_ sender: Any) {
        let commentObject = PFObject(className: "Comments")
        commentObject["from"] = PFUser.current()?.username
        commentObject["to"] = uuidLabel.text
        
        commentObject.saveInBackground { (success, error) in
            if error != nil {
                self.makeAlert(titleInput: "ERROR!", messageInput: error?.localizedDescription ?? "ERROR!")
            }else {
                
            }
        }
    }
    
    
    
    func makeAlert(titleInput : String , messageInput : String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
}
