//
//  UserProfile.swift
//  final-project
//
//  Created by Eman Jihad on 24/12/2021.
//

import UIKit




class UserProfileVC: UIViewController {
    var user: User!
    
   //OUTLET
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var userPicterImageView: UIImageView!{
        didSet{
            userPicterImageView.makeImageCirurlar()
        }
    }
    @IBOutlet weak var userNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
         setupid()
        
        UserAPI.getalluser(id: user.id) { Userone in
            self.user = Userone
            
        
            
            self.setupid()
        }
           
    }
        
        func setupid(){
            
        userNameLabel.text = user.firstName + "" + user.lastName
            
            if let image = user.picture{
            userPicterImageView.setImageForString(stringUrl: image)
            
            }
        emailLabel.text = user.email
        phoneLabel.text = user.phone
        genderLabel.text = user.gender
        
            if let loacation = user.location {
            
    
                countryLabel.text = (loacation.city!) + "/" + (loacation.country!)
            }
       
    }
   
   
    
}
