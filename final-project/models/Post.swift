//
//  Post.swift
//  final-project
//
//  Created by Eman Jihad on 14/12/2021.
//

import Foundation
import UIKit
struct Post : Decodable{
    
    var id: String
    var image: String
    var likes: Int
    var text: String
    var  owner: User
    var tags : [String]?
    
}
