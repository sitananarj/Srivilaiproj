//
//  ScanQRViewController.swift
//  Srivilaiproj
//
//  Created by siwa on 20/2/2563 BE.
//  Copyright © 2563 siwa. All rights reserved.
//

import UIKit
import AVFoundation

class ScanQRViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    var captureSession: AVCaptureSession!
    var preview: AVCaptureVideoPreviewLayer!
    var selectedItem: [String: Any]?
    weak var parentVC: RoomDetailViewController?
    var foundQR = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captureSession = AVCaptureSession()
        
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                captureSession.addInput(input)
                
                preview = AVCaptureVideoPreviewLayer(session: captureSession)
                preview.frame = view.layer.bounds
                preview.videoGravity = .resizeAspectFill
                
                view.layer.addSublayer(preview)
                
                let metadataOutput = AVCaptureMetadataOutput()
                captureSession.addOutput(metadataOutput)
                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                metadataOutput.metadataObjectTypes = [.qr]
                
                captureSession.startRunning()
            } catch {
                print(error)
            }
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            if let value = (metadataObject as? AVMetadataMachineReadableCodeObject)?.stringValue {
                if value == selectedItem!["name"] as? String && !foundQR {
                    foundQR = true
                    parentVC?.foundQR(item: selectedItem!)
                    navigationController?.popViewController(animated: true)
                }
            }
        }
    }

}
