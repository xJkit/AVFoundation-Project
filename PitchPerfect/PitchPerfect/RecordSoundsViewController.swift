//
//  ViewController.swift
//  PitchPerfect
//
//  Created by joey54780 on 4/14/16.
//  Copyright © 2016 SweetJohn. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        print("viewDidLoad called.")
        stopRecordingButton.enabled = false
    }
    
    override func viewWillAppear(animated: Bool) {
//        print("viewWillAppear called.")
        
    }
    
    override func viewDidAppear(animated: Bool) {
//        print("viewDidAppear called.")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        print("audioRecorder finished! and saved the recorded audio file.")
        if (flag) {
            self.performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
        } else {
            print("saving audio file failed...")
        }
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording"){
          let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    

    @IBAction func recordAudio(sender: AnyObject) {
        print("recordAudio Button is Pressed!")
        recordingLabel.text = "錄音進行中..."
        stopRecordingButton.enabled = true
        recordButton.enabled = false
        
        //start to record audio...
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        if let filePath = filePath{
            do{
                print("filePath:\(filePath)")
                try audioRecorder = AVAudioRecorder(URL: filePath, settings: [:])
            }catch{
                print("audioRecorder failed...")
            }
            
        }
        // delegation
        audioRecorder.delegate = self //delegation
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        //end audio recording session
    }

    @IBAction func stopRecording(sender: AnyObject) {
        print("stopRecording is pressed")
        stopRecordingButton.enabled = false
        recordingLabel.text = "按下開始錄音"
        recordButton.enabled = true
        
        //stop recording
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
}

