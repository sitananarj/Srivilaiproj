//
//  GameViewController.swift
//  Srivilaiproj
//
//  Created by siwa on 19/12/2562 BE.
//  Copyright © 2562 siwa. All rights reserved.
//
import UIKit
import ARKit

class GameViewController: UIViewController, ARSCNViewDelegate {
//        let arView: ARSCNView = {
//            let view = ARSCNView()
//            view.translatesAutoresizingMaskIntoConstraints = false
//            return view
//          }()
//
//          let configuration = ARWorldTrackingConfiguration()
//

            override func viewDidLoad() {
                super.viewDidLoad()
                
}
              // Do any additional setup after loading the view, typically from a nib.
              
//              view.addSubview(arView)
//
//              arView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//              arView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//              arView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//              arView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//
//              configuration.planeDetection = .horizontal
//              arView.session.run(configuration, options: [])
//              arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
//
//              arView.delegate = self
//            }
//
//            func create(anchor: ARPlaneAnchor) -> SCNNode {
//              let node = SCNNode()
//              node.name = "floor"
//              node.eulerAngles = SCNVector3(90.degreesToRadians, 0, 0)
//              node.geometry = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
//              node.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "chang1")
//              node.geometry?.firstMaterial?.isDoubleSided = true
//              node.position = SCNVector3(anchor.center.x, anchor.center.y, anchor.center.z)
//              return node
//            }
//
//            func removeNode(named: String) {
//              arView.scene.rootNode.enumerateChildNodes { (node, _) in
//                if node.name == named {
//                  node.removeFromParentNode()
//                }
//              }
//            }
//
//            override func didReceiveMemoryWarning() {
//              super.didReceiveMemoryWarning()
//              // Dispose of any resources that can be recreated.
//            }
//
//            func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
//              guard let anchorPlane = anchor as? ARPlaneAnchor else { return }
//              print("New plane anchor found with extent:", anchorPlane.extent)
//              let planeNode = create(anchor: anchorPlane)
//              node.addChildNode(planeNode)
//            }
//
//            func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
//              guard let anchorPlane = anchor as? ARPlaneAnchor else { return }
//              print("Plane anchor updated with extent:", anchorPlane.extent)
//              removeNode(named: "floor")
//              let planeNode = create(anchor: anchorPlane)
//              node.addChildNode(planeNode)
//            }
//
//            func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
//              guard let anchorPlane = anchor as? ARPlaneAnchor else { return }
//              print("Plane anchor removed with extent:", anchorPlane.extent)
//              removeNode(named: "floor")
 }

          
