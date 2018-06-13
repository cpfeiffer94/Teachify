//
//  QR_ScannerViewController.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 06.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit
import AVFoundation

class QR_ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    @IBOutlet var cameraPreview: UIView!
    var url : String = ""
    var segueWasCalled: Bool = false
    
    enum error : Error {
        case noCameraAvailable
        case videoInitFail
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try scanQRCode()
        }
        catch {
            print("Failed to read the QR Code")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        segueWasCalled = false
    }
    
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count > 0 {
            let machineReadableCode = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            if machineReadableCode.type == AVMetadataObject.ObjectType.qr && !segueWasCalled{
                url = machineReadableCode.stringValue!
                segueWasCalled = true
                performSegue(withIdentifier: "openLink", sender: self)
            }
        }
    }
    
    func scanQRCode() throws {
        let avCaptureSession = AVCaptureSession()
        
        guard let device = AVCaptureDevice.default(for: AVMediaType.video)
            else {
                print("no Camera detected!")
                throw error.noCameraAvailable
        }
        
        guard let avCaptureInput = try? AVCaptureDeviceInput(device: device) else {
            print("failed to init")
            throw error.videoInitFail
        }
        
        let avCaptureMetaDataOutput = AVCaptureMetadataOutput()
        avCaptureMetaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        avCaptureSession.addInput(avCaptureInput)
        avCaptureSession.addOutput(avCaptureMetaDataOutput)
        
        avCaptureMetaDataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        let avCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: avCaptureSession)
        avCaptureVideoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        avCaptureVideoPreviewLayer.frame = cameraPreview.bounds
        
        self.cameraPreview.layer.addSublayer(avCaptureVideoPreviewLayer)
        
        avCaptureSession.startRunning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openLink" {
            let destination = segue.destination as! WebViewController
            destination.myURL = url
        }
    }

    
}
