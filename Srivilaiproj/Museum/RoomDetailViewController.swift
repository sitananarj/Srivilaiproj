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
        
        infoTextView.text = selectedRoom!["info"] as? String
        // Do any additional setup after loading the view.
    }
    
    @objc func touchItem(_ sender: Any) {
        let item = (selectedRoom!["items"] as! [[String: Any]])[(sender as? UIButton)!.tag]
        selectedItem = item
        if item["qr"] as! Bool {
            performSegue(withIdentifier: "scanqr", sender: self)
        } else {
            performSegue(withIdentifier: "showitem", sender: self)
        }
    }
    func foundQR(item: [String: Any]) {
        selectedItem = item
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.performSegue(withIdentifier: "showitem", sender: self)
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "scanqr" {
            let VC = segue.destination as! ScanQRViewController
            VC.selectedItem = selectedItem
            VC.parentVC = self
        } else if segue.identifier == "showitem" {
            let VC = segue.destination as! ShowModelViewController
            VC.selectedItem = selectedItem
        }
    }
    

}
