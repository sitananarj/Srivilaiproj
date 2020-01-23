//
//  ARScanViewController.swift
//  Srivilaiproj
//
//  Created by siwa on 21/1/2563 BE.
//  Copyright © 2563 siwa. All rights reserved.
//

import UIKit
import ARKit

class ARScanViewController: UIViewController, ARSCNViewDelegate {

    
    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let arImage = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil)
        let config = ARWorldTrackingConfiguration()
        config.detectionImages = arImage
        let option: ARSession.RunOptions = [.resetTracking, .removeExistingAnchors]
        sceneView.session.run(config, options: option)
        sceneView.delegate = self
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let image = anchor as? ARImageAnchor {
            DispatchQueue.main.async {
                print(image.name)
                //let object = SCNBox(width: 10, height: 10, length: 10, chamferRadius: 1)
                //let object = SCNPlane(width: image.referenceImage.physicalSize.width, height: image.referenceImage.physicalSize.height)
                
                let scene = SCNScene(named: "scene.scnassets/\(image.name!).scn")!
                let mainNode = scene.rootNode.childNode(withName: "main", recursively: true)!
                let lookCamera = SCNBillboardConstraint()
                lookCamera.freeAxes = .Y
                
                mainNode.constraints = [lookCamera]
                
                node.addChildNode(mainNode)
             
                
//                let mainNode = SCNNode(geometry: object)
//                mainNode.renderingOrder = -1
//                mainNode.opacity = 0.8
//                mainNode.eulerAngles.x = -.pi / 2
                
            }
        }
    }
}
