//
//  InfoHistoricalViewController.swift
//  Srivilaiproj
//
//  Created by siwa on 30/1/2563 BE.
//  Copyright © 2563 siwa. All rights reserved.
//

import UIKit
import  Firebase

class InfoHistoricalViewController: UIViewController {
    
    @IBOutlet weak var imagetop: UIImageView!
    
    @IBOutlet weak var nameplace: UILabel!
    @IBOutlet weak var infohistorical: UITextView!
    
    
    @IBOutlet weak var namezone1: UILabel!
    @IBOutlet weak var imagezone1: UIImageView!
    @IBOutlet weak var infozone1: UITextView!
    
    @IBOutlet weak var nextpagewat: UIButton!
    
    @IBOutlet weak var namezone2: UILabel!
    @IBOutlet weak var imagezone2: UIImageView!
    @IBOutlet weak var infozone2: UITextView!
    
    
    let db = Firestore.firestore()
    var selectName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        db.collection("info-historical-park").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.imagetop.image = try! UIImage(data: Data(contentsOf: URL(string: document.data()["image-top"] as! String)!))
                    
                    
                    self.nameplace.text = document.data()["name-top"] as? String
                    self.infohistorical.text = document.data()["info-historical"] as? String
                    
                    self.namezone1.text = document.data()["name-zone1"] as? String
                    self.imagezone1.image = try! UIImage(data: Data(contentsOf: URL(string: document.data()["image-zone1"] as! String)!))
                    self.infozone1.text = document.data()["info-zone"] as? String
                    
                    self.namezone2.text = document.data()["name-zone2"] as? String
                    self.imagezone2.image = try! UIImage(data: Data(contentsOf: URL(string: document.data()["image-zone2"] as! String)!))
                    self.infozone2.text = document.data()["info-zone2"] as? String
                    
                    
                    
                    // Do any additional setup after loading the view.
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
    }
}
