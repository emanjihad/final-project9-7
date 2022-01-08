//
//  ViewController.swift
//  final-project
//
//  Created by Eman Jihad on 13/12/2021.
//

import UIKit

import NVActivityIndicatorView

class PostVC: UIViewController {
    
    
    @IBOutlet weak var addView: BackView!
    
    @IBOutlet weak var closeButtom: UIButton!
    
    @IBOutlet weak var tagLabel: UILabel!
    
    @IBOutlet weak var tagContinerView: UIView!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var loadeingView: NVActivityIndicatorView!
    
    @IBOutlet weak var postsTableView: UITableView!
    var total = 0
    var page = 0
    var posts: [Post] = []
    var tag: String?
    //var loginuser: User?
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(newPostAdd), name: NSNotification.Name(rawValue: "NewPostAdd"), object: nil)
        
        
        if let mytag = tag{
            
            tagLabel.text = "#\(mytag)"
        }else {
            closeButtom.isHidden = true
            tagContinerView.isHidden = true
          
        }
        
        
        postsTableView.delegate = self
        postsTableView.dataSource = self
        if let user = mangeLogedInUser.logInUser{
            welcomeLabel.text = "Welcome, \(user.firstName)"
        }else {
           // welcomeLabel.isHidden = true
            welcomeLabel.text = "Welcome Guest"
            addView.isHidden = true
            self.tabBarController?.tabBar.items?[2].isEnabled = false
        }
        
        
        //subscribe to notifactione center
        NotificationCenter.default.addObserver(self, selector: #selector(userprofiletaped),name:NSNotification.Name(rawValue: "userstackviewtaped") , object: nil)
        
        getpages()
        
        }
        
   
       
    // Do any additional setup after loading the view.
   


func getpages(){
loadeingView.startAnimating()
    PostAPI.getAllPost(page: page, tag: tag) { postsResponse,totals  in
        self.total = totals
        self.posts.append(contentsOf: postsResponse)
    self.postsTableView.reloadData()
    self.loadeingView.stopAnimating()
}
}
    @objc func newPostAdd(){
        self.posts = []
        self.page = 0
        getpages()
    }

//mark.action
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logoutSegue"{
            mangeLogedInUser.logInUser = nil
    }
    }
    @objc func userprofiletaped(notification: Notification){
        if let cell = notification.userInfo?["cell"] as? UITableViewCell{
        //if let cell = Notification.userInfo?["cell"] as? UITableViewCell{
            if let indexPath = postsTableView.indexPath(for: cell){
                
                let post = posts[indexPath.row]
                
                
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "UserProfileVC") as! UserProfileVC
               
                vc.user = post.owner
                present(vc, animated: true, completion: nil)
                
            }
        }
        
        
            
        
        
         
    }

    @IBAction func backButtom(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
extension PostVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        
        let post = posts[indexPath.row]
        cell.postTextLabel.text = post.text
        //cell.postTextLabel.adjustsFontSizeToFitWidth = true
        //cell.postTextLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
     
        let name = posts[indexPath.row]
        cell.userNameLabel.text = post.owner.firstName + " " + post.owner.lastName
        let like = posts[indexPath.row].likes
        cell.likeLabel.text = "\(like)"
        
        if let tags = post.tags{
        
        cell.tags = tags
        }else {
            cell.tags = []
        }
        //fill image by url
        
        let imageStringUrl = post.image
        cell.postImageView.setImageForString(stringUrl: imageStringUrl)
        
   
        let imageStringUrls = post.owner.picture
        //fill user picture
        cell.userPictuerview.makeImageCirurlar()
        if let image = imageStringUrls{
        cell.userPictuerview.setImageForString(stringUrl: image)
            
        }
                
       
      
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 609
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedpost = posts[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "PostDetails") as! PostDetailsVC
        vc.post = selectedpost
       // vc.user = loginuser
        //mangeLogedInUser.logInUser = loginuser
        present(vc, animated: true, completion: nil)
        
        
        
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == posts.count - 1 && posts.count < total{
            page = page + 1
           
            getpages()
            
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
       
        }
}

