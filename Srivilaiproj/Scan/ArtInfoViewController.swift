//
//  ArtInfoViewController.swift
//  Srivilaiproj
//
//  Created by siwa on 25/1/2563 BE.
//  Copyright © 2563 siwa. All rights reserved.
//
import UIKit
import Firebase

class ArtInfoViewController: UIViewController {
    
    @IBOutlet weak var toptitle: UILabel!
    
    @IBOutlet weak var top1image: UIImageView!
    @IBOutlet weak var top1title: UILabel!
    @IBOutlet weak var top1body: UITextView!
    
    @IBOutlet weak var top2image: UIImageView!
    @IBOutlet weak var top2title: UILabel!
    @IBOutlet weak var top2body: UITextView!
    
    @IBOutlet weak var bottomtitle: UILabel!
    
    @IBOutlet weak var bottom1image: UIImageView!
    @IBOutlet weak var bottom1title: UILabel!
    @IBOutlet weak var bottom1body: UITextView!
    
    let db = Firestore.firestore()
    var selectName = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        db.collection("arts").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.toptitle.text = document.data()["top-title"] as? String
                        
                        self.top1image.image = try? UIImage(data: Data(contentsOf: URL(string: document.data()["top1-image"] as! String)!))
                        self.top1title.text = document.data()["top1-title"] as? String
                        self.top1body.text = document.data()["top1-body"] as? String
                        
                        self.top2image.image = try? UIImage(data: Data(contentsOf: URL(string: document.data()["top2-image"] as! String)!))
                        self.top2title.text = document.data()["top2-title"] as? String
                        self.top2body.text = document.data()["top2-body"] as? String
                        
                        self.bottomtitle.text = document.data()["bottom-title"] as? String
                        
                        self.bottom1image.image = try? UIImage(data: Data(contentsOf: URL(string: document.data()["bottom1-image"] as! String)!))
                        self.bottom1title.text = document.data()["bottom1-title"] as? String
                        self.bottom1body.text = document.data()["bottom1-body"] as? String
                        
                    
                    }
                }
        }
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

}
