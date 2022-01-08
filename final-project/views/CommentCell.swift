//
//  CommentCell.swift
//  final-project
//
//  Created by Eman Jihad on 17/12/2021.
//

import UIKit
import NVActivityIndicatorView
class CommentCell: UITableViewCell {
    
    
    @IBOutlet weak var userComment: UILabel!
    
    @IBOutlet weak var commetLabels: UILabel!
    
    @IBOutlet weak var userImage: UIImageView!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
        
        
        
        // Configure the view for the selected state
    }

}
