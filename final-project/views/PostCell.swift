//
//  PostCell.swift
//  final-project
//
//  Created by Eman Jihad on 14/12/2021.
//

import UIKit

class PostCell: UITableViewCell {
    var tags: [String] = []
    @IBOutlet weak var tagsCollectionView: UICollectionView!{
        didSet{
            tagsCollectionView.delegate = self
            tagsCollectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var userStackView: UIStackView!{
        didSet{
            
            userStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userstackviewtaped)))
        
    }
                                               
                                               }
                                               
                                               
    @IBOutlet weak var likeLabel: UILabel!
    
    
   
    
    @IBOutlet weak var userPictuerview: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
            }
       @objc func userstackviewtaped(){
           NotificationCenter.default.post(name: NSNotification.Name("userstackviewtaped"), object: nil, userInfo: ["cell" : self])
    
    }
}
extension PostCell: UICollectionViewDelegate,  UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postTagCell", for:
                                            indexPath)as! TagCell
        cell.tagNameLabel.text = tags[indexPath.row]
        
        return cell
    }
    
    
}




