//
//  ViewController.swift
//  Srivilaiproj
//
//  Created by siwa on 19/12/2562 BE.
//  Copyright © 2562 siwa. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet var videoPreview: UIView!
    var stringURL = String()
    
    enum error: Error {
        case noCameraAvailabble
        case videoInputInitFail
    }
       override func viewDidLoad() {
        super.viewDidLoad()
        do {
            
        }catch {
            print("Failed to scan the QRCode")
        }
    }
    override func didReceiveMemoryWarning() {
               super.didReceiveMemoryWarning()
    }
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if metadataObjects.count > 0 {
                let mechineReadableCode = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
                if mechineReadableCode.type == AVMetadataObject.ObjectType.qr {
                    print(mechineReadableCode.stringValue!)
//                   performSegue(withIdentifier: "openLink", sender: self)
//    func captureOutput( captureOutput: AVCaptureOutput!, didOutput metadataObjects: [Any?], from: AVCaptureConnection) {
//        if metadataObjects.count > 0 {
//            let mechineReadableCode = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
//            if mechineReadableCode.type == AVMetadataObject.ObjectType.qr {
//                stringURL = mechineReadableCode.stringValue!
//                performSegue(withIdentifier: "openLink", sender: self)
                }
            }
        }
      func scanQRCode() throws {
            let avCaptureSession = AVCaptureSession()
            guard let avCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
                print("No camera.")
                throw error.noCameraAvailabble
            }
            guard let avCaptureInput = try? AVCaptureDeviceInput(device: avCaptureDevice) else {
                print("Failed to init camera.")
                throw error.videoInputInitFail
            }
            let avCaptureMetadataOutput = AVCaptureMetadataOutput()
            avCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue:DispatchQueue.main)
    
            avCaptureSession.addInput(avCaptureInput)
            avCaptureSession.addOutput(avCaptureMetadataOutput)
    
            avCaptureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
    
            let avCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: avCaptureSession)
            avCaptureVideoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            avCaptureVideoPreviewLayer.frame = videoPreview.bounds
            self.videoPreview.layer.addSublayer(avCaptureVideoPreviewLayer)
    
            avCaptureSession.startRunning()
        }
       override func prepare(for segue: UIStoryboardSegue, sender: Any?){
            if segue.identifier == "openLink" {
                let destination = segue.destination as! WebViewController
                destination.url = URL(string: stringURL)
            }
 }

}

