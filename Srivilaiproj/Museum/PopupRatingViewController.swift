//
//  PopupRatingViewController.swift
//  Srivilaiproj
//
//  Created by siwa on 4/4/2563 BE.
//  Copyright © 2563 siwa. All rights reserved.
//

import UIKit
import Firebase

class PopupRatingViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    
    var name: String?
    var place: String?
    var rating: Int = 0
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerLabel.text = name
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func touchStar1(_ sender: Any) {
        rating = 1
        updateStar()
    }
    
    @IBAction func touchStar2(_ sender: Any) {
        rating = 2
        updateStar()
    }
    
    @IBAction func touchStar3(_ sender: Any) {
        rating = 3
        updateStar()
    }
    
    @IBAction func touchStar4(_ sender: Any) {
        rating = 4
        updateStar()
    }
    
    @IBAction func touchStar5(_ sender: Any) {
        rating = 5
        updateStar()
    }
    
    func updateStar() {
        star1.setImage(UIImage(named: "star01"), for: .normal)
        star2.setImage(UIImage(named: "star01"), for: .normal)
        star3.setImage(UIImage(named: "star01"), for: .normal)
        star4.setImage(UIImage(named: "star01"), for: .normal)
        star5.setImage(UIImage(named: "star01"), for: .normal)
        
        if rating >= 1 {
            star1.setImage(UIImage(named: "star02"), for: .normal)
        }
        if rating >= 2 {
            star2.setImage(UIImage(named: "star02"), for: .normal)
        }
        if rating >= 3 {
            star3.setImage(UIImage(named: "star02"), for: .normal)
        }
        if rating >= 4 {
            star4.setImage(UIImage(named: "star02"), for: .normal)
        }
        if rating >= 5 {
            star5.setImage(UIImage(named: "star02"), for: .normal)
        }
    }
    
    @IBAction func touchSave(_ sender: Any) {
        if rating > 0 {
            db.collection("ratings").addDocument(data: ["place": place!, "star": rating, "udid": UIDevice.current.identifierForVendor!.uuidString]) { error in
                UserDefaults.standard.set(self.place!, forKey: self.place!)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
