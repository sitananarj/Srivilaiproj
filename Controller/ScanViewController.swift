//
//  ScanViewController.swift
//  Srivilaiproj
//
//  Created by siwa on 19/12/2562 BE.
//  Copyright © 2562 siwa. All rights reserved.
//
import UIKit
import ARKit
class ScanViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
   override func viewDidLoad() {
        super.viewDidLoad()
    self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
    }
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


