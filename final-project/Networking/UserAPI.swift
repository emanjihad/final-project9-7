//
//  UserAPI.swift
//  final-project
//
//  Created by Eman Jihad on 25/12/2021.
//

import Foundation
import Alamofire
import SwiftyJSON
class UserAPI: API {
    
    
    //GET ALL USER
    static func getalluser(id: String,completionHandeler: @escaping (User) ->()){
       
        let url = urls + "user/\(id)"
        
        AF.request(url , headers: headers).responseJSON {
            
            respons in
            
            let jsonData = JSON(respons.value)
            
            let  decoder = JSONDecoder()
            //convert from json to arrAY  this called decoder
            do {
                let user =  try decoder.decode(User.self, from:jsonData.rawData())
                completionHandeler(user)
               
               // self.setupid()
            }catch let error{
                print(error)
            }
    }
}
    
    //RIGISTER NEW USER
    static func register(firstName: String, lastName: String, email: String ,completionHandeler: @escaping (User?, String?) ->()){
       
        let url = urls + "user/create"
        let params = ["firstName": firstName,"lastName": lastName, "email": email]
        AF.request(url, method: .post, parameters: params,encoder: JSONParameterEncoder.default, headers: headers).validate()
            .responseJSON {
            respons in
                switch respons.result{
                case .success:
                    
                    let jsonData = JSON(respons.value)
                
                let  decoder = JSONDecoder()
               
                do {
                    let user =  try decoder.decode(User.self, from:jsonData.rawData())
                    completionHandeler(user, nil)
                 
                }catch let error{
                    print(error)
                }
                case .failure(let error):
                    
                    let jsonData = JSON(respons.data)
                let data = jsonData["data"]
                   // errorr masge
                    let emailerror = data["email"].stringValue
                    let firstNameErorr = data["firstName"].stringValue
                    let lastNmaeErorr = data["lastName"].stringValue
                   
                    let errorMessage = emailerror + " " + firstNameErorr + " " + lastNmaeErorr
                    
                    completionHandeler(nil, errorMessage)
                   
                }
                
    }
    
    
}
    //SIGNIN
    
    static func signin(firstName: String, lastName: String ,completionHandeler: @escaping (User?, String?) ->()){
       
        let url = urls + "/user"
        let params = ["created": "1"]
        //QUEREY PARAM
        AF.request(url, method: .get, parameters: params,encoder: URLEncodedFormParameterEncoder.default, headers: headers).validate()
            .responseJSON {
            respons in
                switch respons.result{
                case .success:
                    
                    let jsonData = JSON(respons.value)
                    let data = jsonData["data"]
                    print(jsonData)
                let  decoder = JSONDecoder()
               
                do {
                    let users =  try decoder.decode([User].self, from: data.rawData())
                    
                    var foundUser: User?
                    for user in users{
                        if user.firstName == firstName && user.lastName == lastName {
                            foundUser = user
                            break
                        }
                    }
                    if let user = foundUser {
                        completionHandeler(user, nil)}
                    
                    else {
                        completionHandeler(nil, "the First name and the Last name don't match any user")
                    }
                 
                 
                }catch let error{
                    print(error)
                }
                case .failure(let error):
                    
                    let jsonData = JSON(respons.data)
                let data = jsonData["data"]
                   // errorr masge
                    let emailerror = data["email"].stringValue
                    let firstNameErorr = data["firstName"].stringValue
                    let lastNmaeErorr = data["lastName"].stringValue
                   
                    let errorMessage = emailerror + " " + firstNameErorr + " " + lastNmaeErorr
                    
                    
                    
                    completionHandeler(nil, errorMessage)
                   
            
                    
                }
                
         
            }
        
    }
    
    static func updateUserInfo(userid: String, firstName: String,lastName: String, phone: String ,imageUrl: String ,completionHandeler: @escaping (User?, String?) ->()){
        let url = urls + "/user/\(userid)"
        let params = ["firstName": firstName ,"lastName": lastName, "phone": phone, "picture": imageUrl]
        //QUEREY PARAM
        AF.request(url, method: .put, parameters: params,encoder: JSONParameterEncoder.default, headers: headers).validate()
            .responseJSON {
            respons in
                switch respons.result{
                case .success:
                    let jsonData = JSON(respons.value)
                    print(jsonData)
                let  decoder = JSONDecoder()
               
                do {
                    let user =  try decoder.decode(User.self, from: jsonData.rawData())
                        completionHandeler(user, nil)
                }catch let error{
                    print(error)
                }
                case .failure(let error):
                    
                    let jsonData = JSON(respons.data)
                let data = jsonData["data"]
                   // errorr masge
                    let emailerror = data["email"].stringValue
                    let firstNameErorr = data["firstName"].stringValue
                    let lastNmaeErorr = data["lastName"].stringValue
                   
                    let errorMessage = emailerror + " " + firstNameErorr + " " + lastNmaeErorr
                    
                    completionHandeler(nil, errorMessage)
                    
                }
                
         
            }
        
    }
           
    }
