//
//  TempleDetailViewController.swift
//  Srivilaiproj
//
//  Created by siwa on 16/4/2563 BE.
//  Copyright © 2563 siwa. All rights reserved.
//

import UIKit
import Kingfisher
import Firebase

class TempleDetailViewController: UIViewController {

    
    @IBOutlet weak var imgTemple: UIImageView!
    
    @IBOutlet weak var nameTemple: UILabel!
    
    @IBOutlet weak var infoTemple: UITextView!
    
    @IBOutlet weak var mapTemple: UIImageView!
    
    let db = Firestore.firestore()
    var selectName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db.collection("temples").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    self.imgTemple.image = try! UIImage(data: Data(contentsOf: URL(string: (document.data()["img-slide"] as? String)!)!))
                    
                    self.nameTemple.text = document.data()["name-temple"] as? String
                    self.infoTemple.text = document.data()["info-temple"] as? String
                    
                    self.mapTemple.image = try! UIImage(data: Data(contentsOf: URL(string: (document.data()["map-temple"] as? String)!)!))
                    
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
