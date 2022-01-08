//
//  NewPOSTVC.swift
//  final-project
//
//  Created by Eman Jihad on 03/01/2022.
//

import UIKit
import NVActivityIndicatorView
import Spring

class NewPOSTVC: UIViewController {

   //OUTLET
    @IBOutlet weak var postImageView: SpringImageView!
    
    @IBOutlet weak var newLabel: SpringLabel!
    @IBOutlet weak var addButoon: SpringButton!
    @IBOutlet weak var textTextField: UITextField!
    
    @IBOutlet weak var loader: NVActivityIndicatorView!
    
    @IBOutlet weak var imageTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    
        newLabel.animation = "zoomIn"
        newLabel.delay = 0.5
        newLabel.duration = 2
        newLabel.animate()
        postImageView.animation = "flash"
        postImageView.delay = 1
        postImageView.duration = 0.6
        postImageView.animate()
    }
    //ACTION
    @IBAction func newPostButton(_ sender: Any){
        if let user = mangeLogedInUser.logInUser{
            PostAPI.addNewPost(text: textTextField.text!, userid: user.id, image: imageTextField.text!){
                self.addButoon.setTitle("", for: .normal)
                self.loader.startAnimating()
              
                self.addButoon.setTitle("AddNewPost", for: .normal)
                NotificationCenter.default.post(name: NSNotification.Name("NewPostAdd"), object: nil, userInfo: nil)
                self.dismiss(animated: true, completion: nil)
                
                
                
    }
    
    }
}
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
