//
//  EditUserVC.swift
//  final-project
//
//  Created by Eman Jihad on 03/01/2022.
//

import UIKit
import NVActivityIndicatorView
class EditUserVC: UIViewController {
    //OUTLET
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var loaderview: NVActivityIndicatorView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var imagView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var imageTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.isEnabled = true
        phoneTextField.isEnabled = true
        imageTextField.isEnabled = true
        
        setup()
        // Do any additional setup after loading the view.
    }
    
    func setup(){
        imagView.makeImageCirurlar()
        if let user = mangeLogedInUser.logInUser {
            if let image = user.picture {
                imagView.setImageForString(stringUrl: image)
            }
            nameLabel.text = user.firstName + "" + user.lastName
           // nameTextField.text = user.firstName + "" + user.lastName
            nameTextField.text = user.firstName
            lastNameTextField.text = user.lastName
            imageTextField.text = user.picture
            phoneTextField.text = user.phone
        }
        
    }
    
    
    
//ACTION
    @IBAction func submitButton(_ sender: Any) {
        guard let loggedin = mangeLogedInUser.logInUser else {return}
        loaderview.startAnimating()
        UserAPI.updateUserInfo(userid: loggedin.id , firstName: nameTextField.text!, lastName: lastNameTextField.text!, phone: phoneTextField.text!, imageUrl: imageTextField.text!) { user, massage in
            self.loaderview.stopAnimating()
            
            if let responses = user {
               
                if let image = user?.picture {
                self.imagView.setImageForString(stringUrl: image)
            }
                self.nameLabel.text = responses.firstName + "" + responses.lastName
                self.lastNameTextField.text = responses.lastName
                self.phoneTextField.text = responses.phone
               
                
            
            }
            
        }
        
    }
    
    
    @IBAction func changeImageProfile(_ sender: Any) {
        let imagepicker = UIImagePickerController()
        imagepicker.delegate = self
        imagepicker.allowsEditing = true
        present(imagepicker, animated: true, completion: nil)
    }
}
extension EditUserVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        dismiss(animated: true, completion: nil)
        profileImageView.image = image
        
    }
    }


