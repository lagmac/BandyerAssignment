//
//  CameraView.swift
//  BandyerAssignment
//
//  Created by Gino Preti on 26/03/21.
//

import Foundation
import AVFoundation
import UIKit

final class CameraView: UIView
{
    private lazy var videoDataOutput: AVCaptureVideoDataOutput = {
        let v = AVCaptureVideoDataOutput()
        v.alwaysDiscardsLateVideoFrames = true
        v.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
        v.connection(with: .video)?.isEnabled = true
        return v
    }()

    private let videoDataOutputQueue: DispatchQueue = DispatchQueue(label: "JKVideoDataOutputQueue")
    
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let l = AVCaptureVideoPreviewLayer(session: session)
        l.videoGravity = .resizeAspect
        return l
    }()

    private let captureDeviceBack: AVCaptureDevice? = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
    private let captureDeviceFront: AVCaptureDevice? = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
    
    private lazy var session: AVCaptureSession = {
        let s = AVCaptureSession()
        s.sessionPreset = .vga640x480
        return s
    }()

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public func switchCamera()
    {
        guard let cdf = captureDeviceFront, let cdb = captureDeviceBack else { return }
        
        session.beginConfiguration()
        
        let currentInput = session.inputs.first as! AVCaptureDeviceInput
        
        session.removeInput(currentInput)
        
        do
        {
            let deviceCamera = currentInput.device.position == .front ? cdb : cdf
            
            let deviceInput = try AVCaptureDeviceInput(device: deviceCamera)
            
            if session.canAddInput(deviceInput)
            {
                session.addInput(deviceInput)
            }

            session.commitConfiguration()
        }
        catch let error
        {
            debugPrint("\(self.self): \(#function) line: \(#line).  \(error.localizedDescription)")
        }
    }

    private func commonInit()
    {
        contentMode = .scaleAspectFit
        beginSession()
    }

    private func beginSession()
    {
        do
        {
            guard let captureDevice = captureDeviceFront else {
                return
            }
            
            let deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            
            if session.canAddInput(deviceInput)
            {
                session.addInput(deviceInput)
            }

            if session.canAddOutput(videoDataOutput)
            {
                session.addOutput(videoDataOutput)
            }
            
            layer.masksToBounds = true
            layer.addSublayer(previewLayer)
            previewLayer.frame = bounds
            session.startRunning()
        }
        catch let error
        {
            debugPrint("\(self.self): \(#function) line: \(#line).  \(error.localizedDescription)")
        }
    }

    override func layoutSubviews()
    {
        super.layoutSubviews()
        previewLayer.frame = bounds
    }
}

extension CameraView: AVCaptureVideoDataOutputSampleBufferDelegate {}
