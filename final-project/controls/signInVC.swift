//
//  signInVC.swift
//  final-project
//
//  Created by Eman Jihad on 28/12/2021.
//

import UIKit
import Spring

class signInVC: UIViewController {

    @IBOutlet weak var postImageView: SpringImageView!
    @IBOutlet weak var siginButton: SpringButton!
    
    @IBOutlet weak var firstnamTextField: SpringTextField!
    @IBOutlet weak var lastNameTextField: SpringTextField!
    
    @IBOutlet weak var signLabel: SpringLabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lastNameTextField.text = "jihad"
        self.firstnamTextField.text = "eman"
        animat()
        // Do any additional setup after loading the view.
    }
    
    func animat(){
        postImageView.animation = "flash"
        postImageView.delay = 1
        postImageView.duration = 0.6
        postImageView.animate()
        firstnamTextField.animation = "squeezeLeft"
        firstnamTextField.delay = 0.5
        firstnamTextField.duration = 1
        firstnamTextField.animate()
        lastNameTextField.animation =  "squeezeRight"
        lastNameTextField.delay = 0.9
        lastNameTextField.duration = 1
        lastNameTextField.animate()
        firstnamTextField.animate()
        siginButton.animation = "wobble"
        siginButton.delay = 1
        siginButton.duration = 0.5
        siginButton.animate()
        
        signLabel.animation = "squeezeUp"
        signLabel.delay = 2
        signLabel.duration = 2
        signLabel.animate()
    }
    //ACTION
    @IBAction func signInAsGuest(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainTapBarControl")
        
        self.present(vc!, animated: true, completion: nil)
        
    }
    
    
     @IBAction func signInButton(_ sender: Any) {
         UserAPI.signin(firstName: firstnamTextField.text!, lastName: lastNameTextField.text!) { user, errormasege in
             if let message = errormasege{
                 let  alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                 let action = UIAlertAction(title: "ok", style: .default, handler: nil)
                 alert.addAction(action)
                 self.present(alert, animated: true, completion: nil)
             }
             else {
                 if let loggedUser = user {
                     let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainTapBarControl")
                    // vc.loginuser = loggedUser
                     mangeLogedInUser.logInUser = loggedUser
                     self.present(vc!, animated: true, completion: nil)
                     //todo: move to the post view control
                 }
             }
         }
     }
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   // override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    
    

}
