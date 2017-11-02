//
//  ViewController.swift
//  audioGesture
//
//  Created by 6272 on 11/2/2560 BE.
//  Copyright © 2560 6272. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    var audioPlayer: AVAudioPlayer?
    var songs = ["song","mozart-horn-concerto4-3-rondo"]
    var currentSong = 0
    @IBOutlet weak var playBtn: UIButton!
    
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var stopBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAudioFile(audioName: songs[currentSong])
        audioPlayer?.volume = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playMethod(_ sender: Any) {
        if(audioPlayer?.isPlaying)!{
            audioPlayer?.pause()
            playBtn.setTitle("Play", for: UIControlState.normal)
        }
        else{
            audioPlayer?.play()
            playBtn.setTitle("Pause", for: UIControlState.normal)
        }
    }
    
    @IBAction func stopMethod(_ sender: Any) {
        audioPlayer?.stop()
        playBtn.setTitle("Play", for: UIControlState.normal)
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        var playStatus = false
        if(event?.subtype == UIEventSubtype.motionShake){
            print("Shake")
            if(audioPlayer?.isPlaying)!{
                playStatus = true
                audioPlayer?.stop()
            }
            
            setAudioFile(audioName: songs[currentSong])
            
            if(playStatus){
                audioPlayer?.play()
            }
            
        }
    }
    
    private func setAudioFile(audioName:String){
        songNameLabel.text = audioName
        let mySound = NSURL(fileURLWithPath: Bundle.main.path(forResource: audioName, ofType: "mp3")!)
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        }
        catch{
            
        }
        do{
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch{
            
        }
        //        var error:NSError
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: mySound as URL)
        }
        catch let error as NSError{
            print(error)
            audioPlayer = nil
        }
        audioPlayer?.delegate = self as? AVAudioPlayerDelegate
        audioPlayer?.prepareToPlay()
        currentSong = (currentSong+1)%songs.count
    }


}

