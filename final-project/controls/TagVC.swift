//
//  TagVC.swift
//  final-project
//
//  Created by Eman Jihad on 31/12/2021.
//

import UIKit


class TagVC: UIViewController {
    var tags: [String] = []
    //OUTLET
    @IBOutlet weak var tagesCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagesCollectionView.delegate = self
        tagesCollectionView.dataSource = self
            
       // self.loaderView.startAnimating()
        PostAPI.getAllTags {tagss in
         
                self.tags =  tagss
            self.tagesCollectionView.reloadData()
          //  self.loaderView.stopAnimating()
            }
        }
     
}
//UICOLLECTION VIEW PROTOCOL
extension TagVC: UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return(tags.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagsCell", for: indexPath) as! TagsCell
        let currentTag = tags[indexPath.row]
        cell.tagNameLabel.text = currentTag
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = tags[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "PostVC") as! PostVC
        vc.tag = selectedItem
        self.present(vc, animated: true, completion: nil)
    }
    
}




