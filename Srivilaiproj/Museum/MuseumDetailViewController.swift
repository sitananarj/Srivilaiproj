//
//  MuseumDetailViewController.swift
//  Srivilaiproj
//
//  Created by siwa on 23/2/2563 BE.
//  Copyright © 2563 siwa. All rights reserved.
//

import UIKit
import Kingfisher

class MuseumDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoTextView: UITextView!
    
    @IBOutlet weak var planImageView: UIImageView!
    
    var museumData: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
       
        title = museumData!["name"] as? String
        nameLabel.text = museumData!["name"] as? String
        infoTextView.text = museumData!["info"] as? String
        
        planImageView.kf.setImage(with: URL(string: museumData!["plan-img"] as! String))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (museumData!["header-imgs"] as! [NSArray]).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "FullImageCollectionViewCell", for: indexPath) as! FullImageCollectionViewCell
        let imageURL = (museumData!["header-imgs"] as! [String])[indexPath.row]
        cell.imageView.kf.setImage(with: URL(string: imageURL))
        cell.width.constant = UIScreen.main.bounds.width
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 200)
    }
}
