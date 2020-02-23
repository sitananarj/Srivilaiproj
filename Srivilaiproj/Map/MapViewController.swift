//
//  MapViewController.swift
//  Srivilaiproj
//
//  Created by siwa on 11/2/2563 BE.
//  Copyright © 2563 siwa. All rights reserved.
//

import UIKit
import GoogleMaps
import PullUpController
import  Firebase

class MapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    
    let locationManager =  CLLocationManager()
    var isFirstLocation = false
    
    let db = Firestore.firestore()
    var locations: [[String: Any]] = []
    var markers: [GMSMarker] = []
    var VC: PullUpController?
    var currentPosition: CLLocationCoordinate2D?
    var selectedImages: [String]?
    var selectedIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        mapView.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
        
        VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MapDetailViewController") as! PullUpController
        (VC as! MapDetailViewController).parentVC = self
        addPullUpController(VC!, initialStickyPointOffset: 132 + 84, animated: false)
        
        db.collection("locations").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print(document.data())
                    self.locations.append(document.data())
                }
            }
        }
        
        

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImage" {
            let VC = segue.destination as! MapImageViewController
            VC.selectedImages = selectedImages
            VC.selectedIndex = selectedIndex
        }
        
    }
    
    func showHistoryLocation() {
        for marker in markers {
            marker.map = nil
        }
        markers = []
        
        for location in locations {
            if location["type"] as! String == "history" {
                let position = location["position"] as! GeoPoint
                let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: position.latitude, longitude: position.longitude))
                marker.snippet = location["name"] as? String
                
                marker.map = mapView
                
                markers.append(marker)
            }
        }
    }
    
    func showTempleLocation() {
        for marker in markers {
            marker.map = nil
        }
        markers = []
        
        for location in locations {
            if location["type"] as! String == "temple" {
                let position = location["position"] as! GeoPoint
                let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: position.latitude, longitude: position.longitude))
                marker.snippet = location["name"] as? String
                
                marker.map = mapView
                
                markers.append(marker)
            }
        }
    }

    func showMuseumLocation() {
        for marker in markers {
            marker.map = nil
        }
        markers = []
        
        for location in locations {
            if location["type"] as! String == "museum" {
                let position = location["position"] as! GeoPoint
                let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: position.latitude, longitude: position.longitude))
                marker.snippet = location["name"] as? String
                
                marker.map = mapView
                
                markers.append(marker)
            }
        }
    }
    
    func showImage(images: [String], index: Int) {
        selectedImages = images
        selectedIndex = index
        performSegue(withIdentifier: "showImage", sender: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first, !isFirstLocation {
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15)
            isFirstLocation = true
        }
        
        currentPosition = locations.last?.coordinate
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        for location in locations {
            if location["name"] as! String == marker.snippet {
                (VC as! MapDetailViewController).location = location
                
                (VC as! MapDetailViewController).showLocation()


            }
        }
        
        return true
    }
}

