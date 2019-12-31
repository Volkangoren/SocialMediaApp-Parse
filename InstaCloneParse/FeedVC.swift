//
//  FirstViewController.swift
//  InstaCloneParse
//
//  Created by Volkan on 31.12.2019.
//  Copyright © 2019 Volkan. All rights reserved.
//

import UIKit
import Parse

class FeedVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    
    @IBOutlet weak var postTableView: UITableView!
    
    var postOwnerArray = [String]()
    var postCommentArray = [String]()
    var postUUIDArray = [String]()
    var postImageArray = [PFFileObject]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.


        
        postTableView.delegate = self
        postTableView.dataSource = self
       
        getData()
        }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(FeedVC.getData), name: NSNotification.Name(rawValue: "NewPost"), object: nil)
    }
    
   @objc func getData() {
        let query = PFQuery(className: "Posts")
    query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                self.makeAlert(titleInput: "ERROR!", messageInput: error?.localizedDescription ?? "ERROR")
            }else {
                self.postImageArray.removeAll(keepingCapacity: false)
                self.postCommentArray.removeAll(keepingCapacity: false)
                self.postImageArray.removeAll(keepingCapacity: false)
                self.postUUIDArray.removeAll(keepingCapacity: false)
                if objects!.count > 0 {
                    for object in objects! {
                        self.postOwnerArray.append(object.object(forKey: "owner") as! String)
                        self.postCommentArray.append(object.object(forKey: "postcomment") as! String)
                        self.postUUIDArray.append(object.object(forKey: "postuuid") as! String)
                        self.postImageArray.append(object.object(forKey: "image") as! PFFileObject)
                    }
                }
                self.postTableView.reloadData()
            }
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postUUIDArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyCell
        cell.userNameLabel.text = postOwnerArray[indexPath.row]
        cell.commentLabel.text = postCommentArray[indexPath.row]
        cell.uuidLabel.text = postUUIDArray[indexPath.row]
        
        postImageArray[indexPath.row].getDataInBackground { (data, error) in
            if error != nil {
                self.makeAlert(titleInput: "ERROR!", messageInput: error?.localizedDescription ?? "ERROR")
            }else {
                cell.postImage.image = UIImage(data: data!)
            }
        }
        
        return cell
    }
    
    func makeAlert(titleInput : String , messageInput : String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }


}
