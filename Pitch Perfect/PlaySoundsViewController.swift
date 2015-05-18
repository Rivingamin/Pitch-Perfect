//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Riving on 7/5/2015.
//  Copyright (c) 2015 Riving Amin. All rights reserved.



import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    var audioPlayer:AVAudioPlayer!
    var recievedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: recievedAudio.filePathUrl, error: nil)
        audioPlayer = AVAudioPlayer(contentsOfURL: recievedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func clearAudio() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func playAudioSpeed(rate: Float) {
        clearAudio()
        
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    func playAudioPitch(pitch: Float) {
        clearAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }

    @IBAction func playSlowAudio(sender: UIButton) {
        playAudioSpeed(0.5)
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        playAudioSpeed(2.0)
    }
    
    @IBAction func playHighAudio(sender: UIButton) {
        playAudioPitch(1000)
    }
    
    @IBAction func playLowAudio(sender: UIButton) {
        playAudioPitch(-1000)
    }
    
    @IBAction func stopAllAudio(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    


}
