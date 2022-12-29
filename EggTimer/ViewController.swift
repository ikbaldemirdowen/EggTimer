//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player : AVAudioPlayer?
    
    let eggTimes = ["Soft" : 300, "Medium" : 420, "Hard" : 720]
    var secondsRemaning : Int = 0
    var timer = Timer()
    var totalTime : Float = 0.0
    var secondsPassed : Float = 0.0
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var label: UILabel!
    @IBAction func hardnessSelected(_ sender: UIButton)
    {
        self.label.text = "How do you like your eggs?"
        player?.stop()
        secondsPassed = 0.0
        totalTime = 0.0
        timer.invalidate()
        progressView.progress = 0.0
        var eggTime : Int = 0
        let hardness = sender.currentTitle ?? "No title"
        eggTime = eggTimes[hardness]!
        totalTime = Float(eggTime)
        
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.secondsPassed < self.totalTime {
                self.secondsPassed += 1.0
                print(self.secondsPassed)
                let percentageProgress = self.secondsPassed / self.totalTime
                self.progressView.progress = Float(percentageProgress)
                } else {
                    self.label.text = "Your \(hardness.lowercased()) egg is ready! Enjoy it! 😍"
                    self.timer.invalidate()
                    self.playSound()
                }
            }
    }
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
