//
//  PostAPI.swift
//  final-project
//
//  Created by Eman Jihad on 25/12/2021.
//

import Foundation
import Alamofire
import SwiftyJSON
class PostAPI: API {
    
  //GET ALL POSTS.
    
    static  func getAllPost(page: Int, tag: String?, completionHandeler: @escaping ([Post] , Int) ->()){
      var url = urls + "/post"
        if var mytag = tag{
            mytag = mytag.trimmingCharacters(in: .whitespaces)
            url = "\(urls)/tag/\(mytag)/post"
        }
        let  params = ["page": "\(page)", "limit": "5"]
        AF.request(url, parameters: params, encoder: URLEncodedFormParameterEncoder.default ,headers: headers).responseJSON {
          respons in
          let jsonData = JSON(respons.value)
          let data = jsonData["data"]
            let total = jsonData["total"].intValue
          let  decoder = JSONDecoder()
          //convert from json to arrAY  this called decoder
          do {
              let posts =  try decoder.decode([Post].self, from:data.rawData())
              completionHandeler(posts,total)
              
              //self.postsTableView.reloadData()
              
          }catch let error{
              print(error)
          }
          print(data)
      }
      
      }
    
    //ADD NEW POST.
    static func addNewPost(text: String, userid: String,image:String, completionHandeler: @escaping () ->()){
       
        let url = urls + "post/create"
        let params = ["text": text ,  "owner": userid, "image": image]
        AF.request(url, method: .post, parameters: params,encoder: JSONParameterEncoder.default, headers: headers).validate()
            .responseJSON {
            respons in
                switch respons.result{
                case .success:
                    completionHandeler()
                    
              
                case .failure(let error):

                    print(error)
                    

                }
            }
           
    }
    
    //GET POST COMMENT.
    static func getPostComments(id: String,completionHandeler: @escaping ([Comment])-> ()){
   // let appid = "61b776c49d130d5174afcab2"
   
     let url = urls + "post/\(id)/comment"
     
     
         
    
    AF.request(url , headers: headers).responseJSON { respons in
       
        
        let jsonData = JSON(respons.value)
        let data = jsonData["data"]
        
        let  decoder = JSONDecoder()
        
        //convert from json to arrAY  this called decoder
        do {
           let comments =  try decoder.decode([Comment].self, from:data.rawData())
            completionHandeler(comments)
        }catch let error{
            print(error)
        }
       
    }
    

    
}
    // TAGS:
    static  func getAllTags(completionHandeler: @escaping ([String]) ->()){
      let url = urls + "/tag"
      AF.request(url, headers: headers).responseJSON {
          respons in
          let jsonData = JSON(respons.value)
          let data = jsonData["data"]
          let  decoder = JSONDecoder()
          //convert from json to arrAY  this called decoder
          do {
              let tags =  try decoder.decode([String].self, from:data.rawData())
              completionHandeler(tags)
              
              //self.postsTableView.reloadData()
              
          }catch let error{
              print(error)
          }
          print(data)
      }
      
      }
    //MARK ADD NEW COMMENT
    static func addNewCommentTOpost(postId: String, userId: String,message: String ,completionHandeler: @escaping () ->()){
       
        let url = urls + "comment/create"
        let params = ["post": postId , "message": message, "owner":userId]
        AF.request(url, method: .post, parameters: params,encoder: JSONParameterEncoder.default, headers: headers).validate()
            .responseJSON {
            respons in
                switch respons.result{
                case .success:
                    completionHandeler()
                    
              
                case .failure(let error):

                    print(error)
                    

                }
                }
                
    }

}
    
    

