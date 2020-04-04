//
//  PopupStampViewController.swift
//  Srivilaiproj
//
//  Created by siwa on 4/4/2563 BE.
//  Copyright © 2563 siwa. All rights reserved.
//

import UIKit

class PopupStampViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!

    var name: String?
    
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

    @IBAction func touchClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
