//
//  Comment.swift
//  final-project
//
//  Created by Eman Jihad on 17/12/2021.
//

import Foundation
import UIKit
struct Comment: Decodable {
    var id: String
    var owner: User
    var message: String
    
    
}
