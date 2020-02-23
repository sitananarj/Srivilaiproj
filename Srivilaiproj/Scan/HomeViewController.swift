//
//  HomeInfoViewController.swift
//  Srivilaiproj
//
//  Created by siwa on 29/1/2563 BE.
//  Copyright © 2563 siwa. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    @IBOutlet weak var imageshow: UIImageView!
  
    @IBOutlet weak var imagehistory: UIImageView!
    
    @IBOutlet weak var imagemuseum: UIImageView!

    @IBOutlet weak var imagenearby: UIImageView!
    
    var museumData: [String: Any]?
    
    @IBAction func nextpage(_ sender: Any) {
        
    }
    
    let db = Firestore.firestore()
    var selectName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db.collection("histories").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    self.imageshow.image = try! UIImage(data: Data(contentsOf: URL(string: document.data()["image-show"] as! String)!))
                    
                    self.imagehistory.image = try! UIImage(data: Data(contentsOf: URL(string: document.data()["image-history"] as! String)!))
                    
                    self.imagemuseum.image = try! UIImage(data: Data(contentsOf: URL(string: document.data()["image-museum"] as! String)!))
                    
                    self.imagenearby.image = try! UIImage(data: Data(contentsOf: URL(string: document.data()["image-nearby"] as! String)!))
                    
                    
                    
                }
            }
        }
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showmuseum" {
            let VC = segue.destination as! MuseumDetailViewController
            VC.museumData = museumData
        }
    }
    
    @IBAction func touchMuseum1(_ sender: Any) {
        db.collection("museums").whereField("name", isEqualTo: "KamphaengphetNational Museum").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.museumData = document.data()
                }
                
                self.performSegue(withIdentifier: "showmuseum", sender: self)
            }
        }
        //
    }
}
