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
import AVFoundation
import FBSDKShareKit
import FBSDKCoreKit
import Alamofire

class MuseumDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate {

    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoTextView: UITextView!
    
    @IBOutlet weak var planImageView: UIImageView!
    @IBOutlet weak var planView: UIView!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var shareView: UIView!
    
    var museumData: [String: Any]?
    var selectedRoom: [String: Any]?
    var imgs: [UIImageView] = []
    
    var soundPlayer: AVAudioPlayer!
    var isPlay: Bool = false
    
    let locationManager =  CLLocationManager()
    var isFirstLocation = false
    var currentPosition: CLLocationCoordinate2D?
    var currentLine: GMSPolyline?
    var currentMarker: GMSMarker?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = false
       
        title = museumData!["name"] as? String
        nameLabel.text = museumData!["name"] as? String
        infoTextView.text = museumData!["info"] as? String
        
        planImageView.kf.setImage(with: URL(string: museumData!["plan-img"] as! String))
        
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
        
        KingfisherManager.shared.retrieveImage(with: ImageResource(downloadURL: URL(string: museumData!["share-img"] as! String)!)) { result in
            if let image = try? result.get().image {
                let content: SharePhotoContent = SharePhotoContent()
                content.photos = [SharePhoto(image: image, userGenerated: false)]
                
                let shareButton: FBShareButton = FBShareButton()
                shareButton.shareContent = content
                self.shareView.addSubview(shareButton)
                shareButton.frame = CGRect(x: 0, y: 0, width: self.shareView.bounds.width, height: self.shareView.bounds.height)
            }
        }
    }
    
    func createMap() {
        let currentLat = currentPosition!.latitude
        let currentLng = currentPosition!.longitude
        
        let position = museumData!["position"] as! GeoPoint
        let destLat = position.latitude
        let destLng = position.longitude
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: position.latitude, longitude: position.longitude))
        marker.map = mapView
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(currentLat),\(currentLng)&destination=\(destLat),\(destLng)&key=AIzaSyBqY3XusEV5jSUK_ThcXZlu2fMk4qSW68o"
        
        print(url)
        
        AF.request((URL(string: url))!).responseJSON { json in
            
            print(json)
            
            let dict = try! JSONSerialization.jsonObject(with: json.data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [String: AnyObject]
            DispatchQueue.main.async {
                let routes = dict["routes"] as! [Any]
                let bestRoute = routes.first as! [String: Any]
                let polyline = bestRoute["overview_polyline"] as! [String: Any]
                let points = polyline["points"] as! String
                let legs = bestRoute["legs"] as! [Any]
                let bestLeg = legs.first as! [String: Any]
                let duration = bestLeg["duration"] as! [String: Any]
                let text = duration["text"] as! String
 
                self.showPath(text: text, pathString: points, dest: CLLocationCoordinate2D(latitude: destLat, longitude: destLng))
                
            }
        }
    }
    
    func showPath(text: String, pathString: String, dest: CLLocationCoordinate2D) {
        currentLine?.map = nil
        
        let path = GMSPath.init(fromEncodedPath: pathString)
        currentLine = GMSPolyline.init(path: path)
        currentLine?.strokeWidth = 7
        currentLine?.strokeColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        currentLine?.map = mapView
        
        let centerIndex = Int((path?.count())! / 2)
        let centerPosition = path?.coordinate(at: UInt(centerIndex))
        currentMarker?.map = nil
        
        currentMarker = GMSMarker(position: centerPosition!)
        currentMarker?.title = text
        currentMarker?.icon = UIImage(named: "right-icon-rollover")
        currentMarker?.map = mapView
        mapView.selectedMarker = currentMarker
        
        let bounds = GMSCoordinateBounds(coordinate: currentPosition!, coordinate: dest)
        mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 100))
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
    
    @IBAction func touchSound(_ sender: Any) {
        if !isPlay {
            let language = UserDefaults.standard.string(forKey: "language") ?? "EN"
            if let url = Bundle.main.url(forResource: "\(museumData!["name"] as! String)_\(language)", withExtension: "mp4") {
                do {
                    soundPlayer = try AVAudioPlayer(contentsOf: url)
                    soundPlayer.play()
                    
                    isPlay = true
                } catch {
                    print(error)
                }
            }
        } else {
            soundPlayer.stop()
            
            isPlay = false
        }
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
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first, !isFirstLocation {
            currentPosition = location.coordinate
            isFirstLocation = true
            createMap()
        }
    }
}
