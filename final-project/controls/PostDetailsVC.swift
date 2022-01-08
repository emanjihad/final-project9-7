//
//  PostDetailsVC.swift
//  final-project
//
//  Created by Eman Jihad on 16/12/2021.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class PostDetailsVC: UIViewController {
    var post : Post!
    var comment: [Comment] = []
   // var user: User?
    //outlet object
    
    
   
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    
    
    @IBOutlet weak var commentTableview: UITableView!
    
    @IBOutlet weak var userimageview: UIImageView!
    
    @IBOutlet weak var userImage: UIView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var postLabel: UILabel!
    
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var likeLabel: UILabel!
    
    
    @IBOutlet weak var commentTextFiled: UITextField!
    
    
    @IBOutlet weak var commentStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if mangeLogedInUser.logInUser == nil{
            commentStackView.isHidden = true
            
            
        }
        
        commentTableview.delegate = self
        commentTableview.dataSource = self
        
        
        userNameLabel.text = post.owner.firstName + "" + post.owner.lastName
        postLabel.text = post.text
        likeLabel.text = String(post.likes)
        if let image = post.owner.picture{
        userimageview.setImageForString(stringUrl: image)
        }
        postImage.setImageForString(stringUrl: post.image)
        
        userimageview.makeImageCirurlar()
        loaderView.startAnimating()
        getpostcomment()

    }
        
        
    func getpostcomment(){
        loaderView.startAnimating()
        PostAPI.getPostComments(id: post.id) { commentsrespons in
            self.comment = commentsrespons
            self.commentTableview.reloadData()
            self.loaderView.stopAnimating()
        }
        
    }
    //ACTION
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
        
    }

    @IBAction func commentSendButton(_ sender: Any) {
        let message = commentTextFiled.text!
        if let loggedinuser = mangeLogedInUser.logInUser {
        
            PostAPI.addNewCommentTOpost(postId: post.id, userId: loggedinuser.id, message: message) {
                //self.loaderView.startAnimating()
                self.commentTextFiled.text = ""
                self.getpostcomment()
               // self.loaderView.stopAnimating()
           
        }
            
        }
    }
   
}
extension PostDetailsVC : UITableViewDelegate ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(comment.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
  
        let currentcommet = comment[indexPath.row]
        
            cell.commetLabels.text = currentcommet.message
        
        cell.userComment.text = currentcommet.owner.firstName + "" + currentcommet.owner.lastName + ":"
        
        //comment user image
        if let picteruser = currentcommet.owner.picture{
        cell.userImage.setImageForString(stringUrl: picteruser)
        
        
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
        
    }
    
    
}

