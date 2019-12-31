//
//  SecondViewController.swift
//  InstaCloneParse
//
//  Created by Volkan on 31.12.2019.
//  Copyright © 2019 Volkan. All rights reserved.
//

import UIKit
import Parse

class UploadVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePhoto))
        imageView.addGestureRecognizer(gestureRecognizer)
        
     
    }

    @objc func choosePhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func uploadClicked(_ sender: Any) {
        
        let object = PFObject(className: "Posts")
        
        let data = imageView.image?.jpegData(compressionQuality: 0.5)
        let pfImage = PFFileObject(name: "image.jpg", data: data!)
        
        let uuid = UUID().uuidString
        
        
        object["image"] = pfImage
        object["postcomment"] = commentText.text!
        object["owner"] = PFUser.current()?.username
        object["postuuid"] = uuid
        
        object.saveInBackground { (success, error) in
            if error != nil {
                let alert = UIAlertController(title: "ERROR!", message: error?.localizedDescription ?? "error!", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else {
                self.tabBarController?.selectedIndex = 0
                self.commentText.text! = ""
                self.imageView.image! = UIImage(named: "select.png")!
                
                NotificationCenter.default.post(name: NSNotification.Name("NewPost"), object: nil)
            }
        }
        
    }
    
}

