//
//  UimageString.swift
//  final-project
//
//  Created by Eman Jihad on 22/12/2021.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageForString(stringUrl: String){
        
       if  let url = URL(string: stringUrl){
            
            if let imageData = try? Data(contentsOf: url){
           
               self.image = UIImage(data: imageData)
            }
        }
        

        }
        func makeImageCirurlar(){
            self.layer.cornerRadius = self.frame.width / 2
            
        }
        
    }
    
                         
    

