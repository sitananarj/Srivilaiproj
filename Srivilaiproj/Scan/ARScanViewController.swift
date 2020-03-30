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
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var diffButton: UIButton!
    
    var mainNode: SCNNode?
    var showA = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(button)
//        button.layer.cornerRadius = 10
//        button.backgroundColor = UIColor.init(red: 48/255, green: 155/255, blue: 255/255, alpha: 1)
//        button.setTitle("Information", for: .normal)
//
//        var constraints = {
//            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80)
//        }
        let arImage = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) //เรียก Image มาจาก Folder
        let config = ARWorldTrackingConfiguration() //ตั้งค่า Tracking กำหนดทิศทาง
        config.detectionImages = arImage
        let option: ARSession.RunOptions = [.resetTracking, .removeExistingAnchors]
        // ตั้งงค่า Tracking กำหนดทิศทาง RunOptionsเริ่มประมวลผลจุดที่สแกน resetTracking removeExistingAnchors รี,เอาวัตถุออก
        sceneView.session.run(config, options: option) //run objects ภาพที่ตรงกับที่จะส่อง
        sceneView.delegate = self
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ArtInfoViewController
        vc.selectName = "Wat Chang Rop"
        vc.selectName = "Wat Sigha"
    }
    @IBAction func touchInfo(_ sender: Any) {
        performSegue(withIdentifier: "info", sender: self)
    }
    
    @IBAction func touchDiff(_ sender: Any) {
        if showA {
            mainNode?.childNode(withName: "a", recursively: true)?.isHidden = true
            mainNode?.childNode(withName: "b", recursively: true)?.isHidden = false
            
            showA = false
        } else {
            mainNode?.childNode(withName: "a", recursively: true)?.isHidden = false
            mainNode?.childNode(withName: "b", recursively: true)?.isHidden = true
            
            showA = true
        }
    }
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let image = anchor as? ARImageAnchor { //อ้างอิงจุดยึดรูปภาพ /ข้อมูลเกี่ยวกับตำแหน่งและทิศทางของภาพที่ตรวจพบในเซสชัน AR
            DispatchQueue.main.async { //First in - First out
                print(image.name)
                //let object = SCNBox(width: 10, height: 10, length: 10, chamferRadius: 1)
                //let object = SCNPlane(width: image.referenceImage.physicalSize.width, height: image.referenceImage.physicalSize.height)
                let scene = SCNScene(named: "scene.scnassets/\(image.name!).scn")! //ไปเรียก object ที่สร้างมา (โหลดจากfolderที่สร้างไว้)
                self.mainNode = scene.rootNode.childNode(withName: "main", recursively: true)!// โหลดจาก main ย่อยใน scene อีกที
                let lookCamera = SCNBillboardConstraint() //กำหนดแกน
                lookCamera.freeAxes = .Y

                self.mainNode?.constraints = [lookCamera]
                
                node.addChildNode(self.mainNode!)
                
                self.infoButton.isHidden = false
                self.diffButton.isHidden = false
//                let mainNode = SCNNode(geometry: object)
//                mainNode.renderingOrder = -1
//                mainNode.opacity = 0.8
//                mainNode.eulerAngles.x = -.pi / 2
                
            }
        }
    }
}
