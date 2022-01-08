//
//  User.swift
//  final-project
//
//  Created by Eman Jihad on 15/12/2021.
//

import Foundation
import UIKit
struct User : Decodable{
    var id : String
    var firstName: String
    var picture: String?
    
    var lastName: String
    var phone: String?
    var email: String?
    var gender: String?
    var location: Loaction?
}
