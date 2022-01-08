//
//  BackView.swift
//  final-project
//
//  Created by Eman Jihad on 23/12/2021.
//

import UIKit

class BackView: UIView {
    override init(frame: CGRect){
    super.init(frame: frame)
        shadowbackvier()
    
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        shadowbackvier()
       
    }
    func shadowbackvier(){
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
        
        self.layer.shadowRadius = 7
        self.layer.cornerRadius = 5
        
        
        
    }
    
    
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
