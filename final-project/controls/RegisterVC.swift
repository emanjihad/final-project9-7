//
//  RegisterVC.swift
//  final-project
//
//  Created by Eman Jihad on 27/12/2021.
//

import UIKit
import NVActivityIndicatorView

class RegisterVC: UIViewController {

    @IBOutlet weak var firstNameTextFiled: UITextField!
    
    @IBOutlet weak var lastNameTextFiled: UITextField!
    
    @IBOutlet weak var emailTextFiled: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    

    @IBAction func registerButton(_ sender: Any) {
        UserAPI.register(firstName: firstNameTextFiled.text!, lastName: lastNameTextFiled.text!, email: emailTextFiled.text!) { user,errormesasge in if errormesasge != nil {
            let alert = UIAlertController(title: "Error", message: errormesasge, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Oky", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)}
            else{
                let alert = UIAlertController(title: "Sucess", message: "user created", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style:.default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
        }
        }
    }
    
    @IBAction func alreadyRigisterButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
  

}
