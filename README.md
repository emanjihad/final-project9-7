![App Brewery Banner](Documentation/AppBreweryBanner.png)

# POST EMAN
## v 1.0
### The POST EMAN is an iOS application that organizes the post you can make or show it.


####Application Features.
1-It is simple iOS Application built by swift,which displays,addnew post ,and comment,browes post ,creat user and update your profile .
2- I USE MVC (DESIGN PATEERN)
3- NETWORKING
4- Api("https://dummyapi.io/data/v1/")
##### Our Goal

This application make to  add a post and browse the current post you can add picture or text and you can see the post by tags.
###### library & Api use
Alamofire
SwiftyJSON
Spring
IQKEYBOARDMANGER 
NVActivityIndicatorView
IQKeyboardManagerSwift

API
("https://dummyapi.io/data/v1/").

###### Code Sample 
import Foundation
import Alamofire
import SwiftyJSON
class PostAPI: API {

    static  func getAllPost(page: Int, tag: String?, completionHandeler: @escaping ([Post] , Int) ->()){
      var url = urls + "/post"
        if var mytag = tag{
            mytag = mytag.trimmingCharacters(in: .whitespaces)
            url = "\(urls)/tag/\(mytag)/post"
        }
        let  params = ["page": "\(page)", "limit": "5"]
        AF.request(url, parameters: params, encoder: URLEncodedFormParameterEncoder.default ,headers: headers).responseJSON {
          respons in
          let jsonData = JSON(respons.value)
          let data = jsonData["data"]
            let total = jsonData["total"].intValue
          let  decoder = JSONDecoder()
          //convert from json to arrAY  this called decoder
          do {
              let posts =  try decoder.decode([Post].self, from:data.rawData())
              completionHandeler(posts,total)
              
              //self.postsTableView.reloadData()
              
          }catch let error{
              print(error)
          }
          print(data)
      }
      
      }
    
    static func addNewPost(text: String, userid: String,image:String, completionHandeler: @escaping () ->()){
       
        let url = urls + "post/create"
        let params = ["text": text ,  "owner": userid, "image": image]
        AF.request(url, method: .post, parameters: params,encoder: JSONParameterEncoder.default, headers: headers).validate()
            .responseJSON {
            respons in
                switch respons.result{
                case .success:
                    completionHandeler()
                    
              
                case .failure(let error):

                    print(error)
                    

                }
                }
           
    }
    //import UIKit

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
                
    
###### Demo
<img src = "https://user-images.githubsercontent.com/Users/emanjihad/Desktop/Screen Shot 2022-01-07 at 9.44.44 PM.png" height = "500"><img src = "https://user-images.githubsercontent.com/Users/emanjihad/Desktop/Screen Shot 2022-01-07 at 9.44.11 PM.png "height = "500"><img src = "https://user-images.githubsercontent.com/Users/emanjihad/Desktop/Screen Shot 2022-01-07 at 9.42.00 PM.png" height = "500"><img src = "https://user-images.githubsercontent/Users/emanjihad/Desktop/Screen Shot 2022-01-07 at 10.13.43 PM.png height = "500">
---

