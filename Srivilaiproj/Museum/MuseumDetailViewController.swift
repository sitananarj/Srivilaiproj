//
//  MuseumDetailViewController.swift
//  Srivilaiproj
//
//  Created by siwa on 23/2/2563 BE.
//  Copyright © 2563 siwa. All rights reserved.
//

import UIKit
import Kingfisher
import GoogleMaps
import Firebase

class MuseumDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoTextView: UITextView!
    
    @IBOutlet weak var planImageView: UIImageView!
    @IBOutlet weak var planView: UIView!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    
    var museumData: [String: Any]?
    var selectedRoom: [String: Any]?
    var imgs: [UIImageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
       
        title = museumData!["name"] as? String
        nameLabel.text = museumData!["name"] as? String
        infoTextView.text = museumData!["info"] as? String
        
        planImageView.kf.setImage(with: URL(string: museumData!["plan-img"] as! String))
        
        let position = museumData!["position"] as! GeoPoint
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: position.latitude, longitude: position.longitude))
        marker.map = mapView
        
        mapView.camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: position.latitude, longitude: position.longitude), zoom: 15)
        
        for (index, room) in (museumData!["rooms"] as! [[String: Any]]).enumerated() {
            let btn = UIButton(frame: CGRect(x: room["x"] as! Int, y: room["y"] as! Int, width: room["width"] as! Int, height: room["height"] as! Int))
            btn.tag = index
            planView.addSubview(btn)
            
            btn.addTarget(self, action: #selector(touchRoom(_:)), for: .touchUpInside)
        }
        
        for (index, room) in (museumData!["rooms"] as! [[String: Any]]).enumerated() {
            var img = UIImageView()
            if let stampPosition = room["stamp"] as? String {
                if stampPosition == "bottom-left" {
                    let width = (room["width"] as! Int) / 2
                    let height = (room["height"] as! Int) / 2
                    img = UIImageView(frame: CGRect(x: room["x"] as! Int, y: (room["y"] as! Int) + height, width: width, height: height))
                }
            } else {
                img = UIImageView(frame: CGRect(x: room["x"] as! Int, y: room["y"] as! Int, width: room["width"] as! Int, height: room["height"] as! Int))
            }
            
            img.image = UIImage(named: "stamp")
            img.contentMode = .scaleAspectFit
            img.tag = index
            planView.addSubview(img)
            
            imgs.append(img)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var getAll: Bool = true
        for (index, room) in (museumData!["rooms"] as! [[String: Any]]).enumerated() {
            if let _ = UserDefaults.standard.string(forKey: room["name"] as! String) {
                imgs[index].alpha = 1
            } else {
                imgs[index].alpha = 0.5
                getAll = false
            }
        }
        
        if getAll && UserDefaults.standard.string(forKey: museumData!["name"] as! String) == nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.33) {
                self.performSegue(withIdentifier: "popuprating", sender: self)
            }
        }
    }
    
    @objc func touchRoom(_ sender: Any) {
        let room = (museumData!["rooms"] as! [[String: Any]])[(sender as? UIButton)!.tag]
        selectedRoom = room
        performSegue(withIdentifier: "showroom", sender: self)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showroom" {
            let VC = segue.destination as! RoomDetailViewController
            VC.selectedRoom = selectedRoom
        } else if segue.identifier == "popuprating" {
            let VC = segue.destination as! PopupRatingViewController
            VC.name = "How was your trip in \(museumData!["name"] as! String)"
            VC.place = museumData!["name"] as? String
        }
    }
    
    
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
