//
//  MapImageViewController.swift
//  Srivilaiproj
//
//  Created by siwa on 20/2/2563 BE.
//  Copyright © 2563 siwa. All rights reserved.
//

import UIKit
import Kingfisher

class MapImageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var selectedImages: [String]?
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.64)
        
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self

        // Do any additional setup after loading the view.
    }
    
  
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func touchBack(_ sender: Any) {
        dismiss(animated: false, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImages!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "FullImageCollectionViewCell", for: indexPath) as! FullImageCollectionViewCell
        let imageURL = selectedImages![indexPath.row]
        cell.imageView.kf.setImage(with: URL(string: imageURL))
        cell.width.constant = UIScreen.main.bounds.width
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 404)
    }
}
