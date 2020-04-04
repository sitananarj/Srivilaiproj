//
//  MapDetailViewController.swift
//  Srivilaiproj
//
//  Created by siwa on 11/2/2563 BE.
//  Copyright © 2563 siwa. All rights reserved.
//

import UIKit
import PullUpController
import Kingfisher
import Alamofire
import Firebase
import CoreLocation

class MapDetailViewController: PullUpController {
//    , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
    
    weak var parentVC: MapViewController?
    var location: [String: Any]?

    
    override var pullUpControllerPreferredSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: (location != nil ? 610 : 132) + 84)
    }
    
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var templeButton: UIButton!
    @IBOutlet weak var museumButton: UIButton!
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.layer.cornerRadius = 16
        
//        imageCollectionView.dataSource = self
//        imageCollectionView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func showLocation() {
        nameLabel.text = location!["name"] as? String
        openLabel.text = "Open: " + (location!["open"] as! String)
        telLabel.text = "Tel: " + (location!["tel"] as! String)
        feeLabel.text = "Fee: " + (location!["fee"] as! String)
        addressLabel.text = "Address: " + (location!["address"] as! String)
        imageCollectionView.reloadData()
        
        pullUpControllerMoveToVisiblePoint(pullUpControllerAllStickyPoints.last!, animated: true, completion: nil)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func touchHistory(_ sender: Any) {
        parentVC?.showHistoryLocation()
    }

    @IBAction func touchTemple(_ sender: Any) {
        parentVC?.showTempleLocation()
    }
    
    @IBAction func touchMuseum(_ sender: Any) {
        parentVC?.showMuseumLocation()
    }
    
    @IBAction func touchNavigate(_ sender: Any) {
        let currentLat = parentVC!.currentPosition!.latitude
        let currentLng = parentVC!.currentPosition!.longitude
        
        let position = location!["position"] as! GeoPoint
        let destLat = position.latitude
        let destLng = position.longitude

        AF.request((URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(currentLat),\(currentLng)&destination=\(destLat),\(destLng)&key=AIzaSyBqY3XusEV5jSUK_ThcXZlu2fMk4qSW68o"))!).responseJSON { json in

            print(json)

            let dict = try! JSONSerialization.jsonObject(with: json.data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [String: AnyObject]
            DispatchQueue.main.async {
                let routes = dict["routes"] as! [Any]
                let bestRoute = routes.first as! [String: Any]
                let polyline = bestRoute["overview_polyline"] as! [String: Any]
                let points = polyline["points"] as! String

                self.pullUpControllerMoveToVisiblePoint(self.pullUpControllerAllStickyPoints.first!, animated: true, completion: nil)

                self.parentVC?.showPath(pathString: points, dest: CLLocationCoordinate2D(latitude: destLat, longitude: destLng))

            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let location = location {
            return (location["images"] as! NSArray).count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "image", for: indexPath) as! LocationImageCollectionViewCell
        let imageURL = (location!["images"] as! NSArray)[indexPath.row]
        cell.imageView.kf.setImage(with: URL(string: imageURL as! String))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 210)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        parentVC?.showImage(images: (location!["images"] as! [String]), index: indexPath.row)
    }
    
    
}

