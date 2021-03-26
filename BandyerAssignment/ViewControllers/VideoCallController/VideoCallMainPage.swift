//
//  ViewController.swift
//  BandyerAssignment
//
//  Created by Gino Preti on 26/03/21.
//

import UIKit

class VideoCallMainPage: UIViewController, VideoCallMainPageDisplayLogic
{
    var hangupButton: UIButton!
    var switchCameraButton: UIButton!
    var muteMicrophoneButton: UIButton!
    var cameraPreview: CameraView!
    var incomingCallView: UIView!
    
    var viewModel: VideoCallMainPageViewModel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.viewModel = VideoCallMainPageViewModel()
        self.viewModel.scene = self
        
        initViewLayout()
    }
    
    func responseToStartCall()
    {
        updateUI()
    }
    
    func responseToCloseCall()
    {
        updateUI()
    }
    
    func responseSwitchCamera()
    {
        self.cameraPreview.switchCamera()
    }
    
    private func updateUI()
    {
        if self.viewModel.onCall
        {
            addCameraPreview()
        }
        else
        {
            self.cameraPreview.removeFromSuperview()
        }
        
        let hangButtonTitle = self.viewModel.onCall ? "CLOSE" : "CALL"
        
        self.hangupButton.setTitle(hangButtonTitle, for: .normal)
        self.switchCameraButton.isHidden = !self.viewModel.onCall
        self.muteMicrophoneButton.isHidden = !self.viewModel.onCall
    }

    private func initViewLayout()
    {
        addIncomingCallView()
        addButtons()
    }
    
    private func addButtons()
    {
        self.hangupButton = UIButton()
        self.hangupButton.setTitle("CALL", for: .normal)
        self.hangupButton.backgroundColor = .green;
        self.view.addSubview(hangupButton)
        self.hangupButton.setConstraint(withWidth: 80,
                                        height: 80,
                                        offsetX: 0,
                                        offSetY: -20,
                                        anchorX: .CenterX,
                                        anchorY: .Bottom,
                                        relativeToView: self.view,
                                        relativeToViewAnchorX: .CenterX,
                                        relativeToViewAnchorY: .Bottom)
        
        self.hangupButton.addTarget(self.viewModel, action: #selector(viewModel.hangup), for: .touchUpInside)
        
        self.switchCameraButton = UIButton()
        self.switchCameraButton.setTitle("SWITCH", for: .normal)
        self.switchCameraButton.isHidden = !self.viewModel.onCall
        self.switchCameraButton.backgroundColor = .red;
        self.view.addSubview(switchCameraButton)
        self.switchCameraButton.setConstraint(withWidth: 80,
                                              height: 80,
                                              offsetX: 20,
                                              offSetY: 0,
                                              anchorX: .Leading,
                                              anchorY: .Bottom,
                                              relativeToView: self.hangupButton,
                                              relativeToViewAnchorX: .Trailing,
                                              relativeToViewAnchorY: .Bottom)
        
        self.switchCameraButton.addTarget(self.viewModel, action: #selector(viewModel.switchCamera), for: .touchUpInside)

        self.muteMicrophoneButton = UIButton()
        self.muteMicrophoneButton.setTitle("MUTE", for: .normal)
        self.muteMicrophoneButton.isHidden = !self.viewModel.onCall
        self.muteMicrophoneButton.backgroundColor = UIColor.blue;
        self.view.addSubview(muteMicrophoneButton)
        self.muteMicrophoneButton.setConstraint(withWidth: 80,
                                                height: 80,
                                                offsetX: -20,
                                                offSetY: 0,
                                                anchorX: .Trailing,
                                                anchorY: .Bottom,
                                                relativeToView: self.hangupButton,
                                                relativeToViewAnchorX: .Leading,
                                                relativeToViewAnchorY: .Bottom)
        
        self.muteMicrophoneButton.addTarget(self.viewModel, action: #selector(viewModel.muteMicrophoneButtonTapped), for: .touchUpInside)
    }
    
    private func addIncomingCallView()
    {
        self.incomingCallView = UIView()
        self.incomingCallView.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        self.view.addSubview(incomingCallView)
        self.incomingCallView.setConstraint(withWidth: self.view.bounds.width,
                                            height: self.view.bounds.height,
                                            offsetX: 10,
                                            offSetY: 10,
                                            anchorX: .CenterX,
                                            anchorY: .CenterY,
                                            relativeToView: self.view,
                                            relativeToViewAnchorX: .CenterX,
                                            relativeToViewAnchorY: .CenterY,
                                            isCentered: true)
    }
    
    private func addCameraPreview()
    {
        self.cameraPreview = CameraView()
        self.cameraPreview.backgroundColor = .yellow
        self.view.addSubview(self.cameraPreview)
        self.cameraPreview.setConstraint(withWidth: 120,
                                         height: 120,
                                         offsetX: -20,
                                         offSetY: 20,
                                         anchorX: .Trailing,
                                         anchorY: .Top,
                                         relativeToView: self.view,
                                         relativeToViewAnchorX: .Trailing,
                                         relativeToViewAnchorY: .Top)
    }
}

