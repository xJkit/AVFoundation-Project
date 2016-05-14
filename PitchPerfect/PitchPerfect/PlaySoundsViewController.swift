//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by joey54780 on 4/18/16.
//  Copyright © 2016 SweetJohn. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    @IBOutlet weak var echoBtn: UIButton!
    @IBOutlet weak var fastBtn: UIButton!
    @IBOutlet weak var chipmunkBtn: UIButton!
    @IBOutlet weak var deathvaderBtn: UIButton!
    @IBOutlet weak var snailBtn: UIButton!
    @IBOutlet weak var reverbBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    
    //variable for PlaySoundsVC+Audio
    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!
    
    enum ButtonType: Int{
        case Echo = 0
        case Fast
        case Chipmunk
        case Vader
        case Snail
        case Reverb
    }
    
    
    @IBAction func playSoundForButton(sender: UIButton){
        print("Play Sound Btn Pressed!")
        switch(ButtonType(rawValue: sender.tag)!){
        case .Echo:
            playSound(echo: true)
        case .Fast:
            playSound(rate: 1.5)
        case .Chipmunk:
            playSound(pitch: 1000)
        case .Vader:
            playSound(pitch: -1000)
        case .Snail:
            playSound(rate: 0.5)
        case .Reverb:
            playSound(reverb: true)
        }
        
        configureUI(.Playing)
    }
    
    @IBAction func stopButtonPressed(sender: AnyObject){
        print("stop button pressed")
        stopAudio()
    }
    
    
    
    var recordedAudio: NSURL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PlaySoundsVC loaded!!!")
        setupAudio()
    }
    
    override func viewWillAppear(animated: Bool) {
        configureUI(.NotPlaying)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
