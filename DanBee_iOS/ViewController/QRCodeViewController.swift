//
//  QRCodeViewController.swift
//  DanBee_iOS
//
//  Created by 남수김 on 22/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let captureDevice = AVCaptureDevice.default(for: .video) else {return}
        
        do {
            print("captureDevice excute")
            captureSession = AVCaptureSession()
            
            // CaptureSession needs an input to capture Data from
            
            let input = try AVCaptureDeviceInput(device: captureDevice)
            if captureSession!.canAddInput(input) {
                captureSession!.addInput(input)
            }
            
            // CaptureSession needs and output to transfer Data to
            let captureMetadataOutput = AVCaptureMetadataOutput()
            
            //We tell our Output the expected Meta-data type
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [.qr]
            
            //영역지정
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = .resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            captureSession?.startRunning()
            
        }
        catch {
            print("CaptureSession Error")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        captureSession?.startRunning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        captureSession?.stopRunning()
    }
    
    
    // MARK: - AVCaptureMetadataOutputObjectsDelegate
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        captureSession?.stopRunning()
        
        
        if metadataObjects.count == 0 {
            print("no objects returned")
            return
        }
        
        let metaDataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        guard let StringCodeValue = metaDataObject.stringValue else {
            return
        }
        
        //transformedMetaDataObject returns layer coordinates/height/width from visual properties
        guard let _ = self.videoPreviewLayer?.transformedMetadataObject(for: metaDataObject) else {
            return
        }
        
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        qrRequest(StringCodeValue)
        
    }
    
    func qrRequest(_ url: String){
        print(url)
    }
    
    
}
