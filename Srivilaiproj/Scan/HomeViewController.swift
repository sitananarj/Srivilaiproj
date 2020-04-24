//
//  HomeInfoViewController.swift
//  Srivilaiproj
//
//  Created by siwa on 29/1/2563 BE.
//  Copyright © 2563 siwa. All rights reserved.
//

import UIKit
import Kingfisher
import Firebase
//import FBSDKLoginKit
//import FBSDKCoreKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var imageshow: UIImageView!
  
    @IBOutlet weak var imagehistory: UIImageView!
    
    @IBOutlet weak var imagemuseum: UIImageView!
    
    @IBOutlet weak var imagenearby: UIImageView!
    
    @IBOutlet weak var loginView: UIView!
    
    var museumData: [String: Any]?
    var historyData: [String: Any]?
    
    @IBAction func nextpage(_ sender: Any) {
    }
    
    let db = Firestore.firestore()
    var selectName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.layer.cornerRadius = 15
        navigationController?.navigationBar.clipsToBounds = true
        
//        self.imagemuseum.layer.cornerRadius = self.imagemuseum.frame.width/8
//        self.imagemuseum.clipsToBounds = true
        imagehistory.layer.cornerRadius = 15
        imagemuseum.layer.cornerRadius = 15
        imagenearby.layer.cornerRadius = 15
        


        


        
        
//        let height: CGFloat = 200
//        let bounds = self.navigationController!.navigationBar.bounds
//        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + height)
//
//        let radius:CGFloat = 30.0
//        self.navigationController?.navigationBar.clipsToBounds = true
//        self.navigationController?.navigationBar.layer.cornerRadius = radius
//        self.navigationController?.navigationBar.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        
//        setLanguageButton()
        
        db.collection("histories").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
//                    self.imageshow.image = try! UIImage(data: Data(contentsOf: URL(string: (document.data()["image-show"] as? String)!)!))
//                    
                    self.imagehistory.image = try! UIImage(data: Data(contentsOf: URL(string: document.data()["image-history"] as! String)!))
                    
                    self.imagemuseum.image = try! UIImage(data: Data(contentsOf: URL(string: document.data()["image-museum"] as! String)!))
                    
                    self.imagenearby.image = try! UIImage(data: Data(contentsOf: URL(string: document.data()["image-nearby"] as! String)!))
                    
                }
            }
        }
        
//        let loginButton: FBLoginButton = FBLoginButton()
//        loginView.addSubview(loginButton)
//        loginButton.frame = CGRect(x: 0, y: 0, width: loginView.bounds.width, height: loginView.bounds.height)

    }
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//           return (historyData!["image-show"] as! [NSArray]).count
//       }
//       
//       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageHomeCollectionViewCell", for: indexPath) as! ImageHomeCollectionViewCell
//           let imageURL = (historyData!["image-show"] as! [String])[indexPath.row]
//           cell.HomeimageView.kf.setImage(with: URL(string: imageURL))
//           cell.Homewidth.constant = UIScreen.main.bounds.width
//           
//           return cell
//       }
//       
//       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//           return CGSize(width: UIScreen.main.bounds.width, height: 300)
//       }
//    
// 
//    func setLanguageButton() {
//        let language = UserDefaults.standard.string(forKey: "language") ?? "EN"
//        let button = UIBarButtonItem(title: language, style: .plain, target: self, action: #selector(changeLanguage))
//        button.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
////        button.titleTextAttributes(for: .normal) = [NSAttributedString.Key.font: UIFont.init(name: "", size: 14)]
//        navigationItem.rightBarButtonItem = button
//    }
//
//    @objc func changeLanguage() {
//        let language = UserDefaults.standard.string(forKey: "language") ?? "EN"
//        if language == "EN" {
//            UserDefaults.standard.set("TH", forKey: "language")
//        } else {
//            UserDefaults.standard.set("EN", forKey: "language")
//        }
//
//        setLanguageButton()
//
////        nameLabel.text = selectedData!["name_" + language] as! String
//
//    }
//
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
    }
}
