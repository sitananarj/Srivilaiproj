//
//  ShowModelViewController.swift
//  Srivilaiproj
//
//  Created by siwa on 23/2/2563 BE.
//  Copyright © 2563 siwa. All rights reserved.
//

import UIKit
import SwiftyGif

class ShowModelViewController: UIViewController {

    @IBOutlet weak var modelImageView: UIImageView!
    
    var currentFrame = 0
    var lastCenter: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gif = try! UIImage(gifName: "yaksa.gif")
        modelImageView.setGifImage(gif)
        
        modelImageView.showFrameAtIndex(currentFrame)
        modelImageView.stopAnimatingGif()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func handlePan(_ sender: Any) {
        let gesture = sender as! UIPanGestureRecognizer
        
        let center = gesture.location(in: view)
        if let lastCenter = lastCenter {
            let distance = lastCenter.x - center.x
            
            currentFrame += Int(distance / 2)
            
            if currentFrame < 0 {
                currentFrame = modelImageView.gifImage!.framesCount() - 1
            } else if currentFrame >= modelImageView.gifImage!.framesCount() {
                currentFrame = 0
            }
            
            modelImageView.showFrameAtIndex(currentFrame)
            modelImageView.stopAnimatingGif()
        }
        
        lastCenter = center
        
    }
    
    @IBAction func touchInfomation(_ sender: Any) {
        performSegue(withIdentifier: "showinfomation", sender: self)
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
