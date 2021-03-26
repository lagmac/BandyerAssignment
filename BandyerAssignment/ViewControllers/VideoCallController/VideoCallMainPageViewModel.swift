//
//  VideoCallMainPageViewModel.swift
//  BandyerAssignment
//
//  Created by Gino Preti on 26/03/21.
//

import Foundation

class VideoCallMainPageViewModel
{
    weak var scene: VideoCallMainPageDisplayLogic?
    
    public var onCall: Bool = false
    
    init()
    {
        
    }
    
    @objc public func hangup()
    {
        guard let sc = scene else { return }
        
        if onCall
        {
            onCall = false
            sc.responseToCloseCall()
        }
        else
        {
            onCall = true
            sc.responseToStartCall()
        }
    }
    
    @objc public func switchCamera()
    {        
        guard let sc = scene else { return }
        
        sc.responseSwitchCamera()
    }
    
    @objc public func muteMicrophoneButtonTapped()
    {
        print("MUTE MICROPHONE...")
    }
}

protocol VideoCallMainPageDisplayLogic: class
{
    func responseToStartCall()
    func responseToCloseCall()
    func responseSwitchCamera()
}
