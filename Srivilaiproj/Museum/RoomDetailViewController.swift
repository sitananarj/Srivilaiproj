//
//  RoomDetailViewController.swift
//  Srivilaiproj
//
//  Created by siwa on 27/2/2563 BE.
//  Copyright © 2563 siwa. All rights reserved.
//

import UIKit
import Kingfisher

class RoomDetailViewController: UIViewController {
    
    
    @IBOutlet weak var roomView: UIView!
    @IBOutlet weak var roomImageView: UIImageView!
    
    @IBOutlet weak var itemStackView: UIStackView!
    
    @IBOutlet weak var infoTextView: UITextView!
    
    @IBOutlet weak var stampImageView: UIImageView!
    @IBOutlet weak var stampLabel: UILabel!
    
    var selectedRoom: [String: Any]?
    var selectedItem: [String: Any]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedRoom!["name"] as? String
        
        roomImageView.kf.setImage(with: URL(string: selectedRoom!["img"] as! String))
        
        for (index, item) in (selectedRoom!["items"] as! [[String: Any]]).enumerated() {
            let btn = UIButton(frame: CGRect(x: item["x"] as! Int, y: item["y"] as! Int, width: item["width"] as! Int, height: item["height"] as! Int))
            btn.tag = index
            roomView.addSubview(btn)
            
            btn.addTarget(self, action: #selector(touchItem(_:)), for: .touchUpInside)
            
            let label = UILabel()
            label.text = item["name"] as? String
            
            itemStackView.addArrangedSubview(label)
        }
        
        let qrBtn = UIButton(frame: CGRect(x: selectedRoom!["qr_x"] as! Int, y: selectedRoom!["qr_y"] as! Int, width: selectedRoom!["qr_width"] as! Int, height: selectedRoom!["qr_height"] as! Int))
        roomView.addSubview(qrBtn)
        
        qrBtn.addTarget(self, action: #selector(touchQr(_:)), for: .touchUpInside)
        
        infoTextView.text = selectedRoom!["info"] as? String
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let _ = UserDefaults.standard.string(forKey: selectedRoom!["name"] as! String) {
            stampImageView.alpha = 1
            stampLabel.text = "You already got \(selectedRoom!["name"] as! String)’s Stamp"
        } else {
            stampImageView.alpha = 0.5
            stampLabel.text = "Please scan QR code for \(selectedRoom!["name"] as! String)’s Stamp"
        }
    }
    
    @objc func touchItem(_ sender: Any) {
        let item = (selectedRoom!["items"] as! [[String: Any]])[(sender as? UIButton)!.tag]
        selectedItem = item
        performSegue(withIdentifier: "showitem", sender: self)
    }
    
    @objc func touchQr(_ sender: Any) {
        performSegue(withIdentifier: "scanqr", sender: self)
    }
    
    func foundQr() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.33) {
            self.performSegue(withIdentifier: "popupstamp", sender: self)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "scanqr" {
            let VC = segue.destination as! ScanQRViewController
            VC.selectedRoom = selectedRoom
            VC.parentVC = self
        } else if segue.identifier == "showitem" {
            let VC = segue.destination as! ShowModelViewController
            VC.selectedItem = selectedItem
        } else if segue.identifier == "popupstamp" {
            let VC = segue.destination as! PopupStampViewController
            VC.name = "\(selectedRoom!["name"] as! String)’s Stamp"
        }
    }
    

}
