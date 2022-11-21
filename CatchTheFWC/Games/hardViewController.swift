//
//  hardViewController.swift
//  CatchTheFWC
//
//  Created by Atalay Çavuşoğlu on 21.11.2022.
//

import UIKit

class hardViewController: UIViewController {
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var kupaArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kupa1: UIImageView!
    @IBOutlet weak var kupa2: UIImageView!
    @IBOutlet weak var kupa3: UIImageView!
    @IBOutlet weak var kupa4: UIImageView!
    @IBOutlet weak var kupa5: UIImageView!
    @IBOutlet weak var kupa6: UIImageView!
    @IBOutlet weak var kupa7: UIImageView!
    @IBOutlet weak var kupa8: UIImageView!
    @IBOutlet weak var kupa9: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scoreLabel.text = "Score: \(score)"
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        
        kupa1.isUserInteractionEnabled = true
        kupa2.isUserInteractionEnabled = true
        kupa3.isUserInteractionEnabled = true
        kupa4.isUserInteractionEnabled = true
        kupa5.isUserInteractionEnabled = true
        kupa6.isUserInteractionEnabled = true
        kupa7.isUserInteractionEnabled = true
        kupa8.isUserInteractionEnabled = true
        kupa9.isUserInteractionEnabled = true
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        kupa1.addGestureRecognizer(recognizer1)
        kupa2.addGestureRecognizer(recognizer2)
        kupa3.addGestureRecognizer(recognizer3)
        kupa4.addGestureRecognizer(recognizer4)
        kupa5.addGestureRecognizer(recognizer5)
        kupa6.addGestureRecognizer(recognizer6)
        kupa7.addGestureRecognizer(recognizer7)
        kupa8.addGestureRecognizer(recognizer8)
        kupa9.addGestureRecognizer(recognizer9)
        
        kupaArray = [kupa1, kupa2, kupa3, kupa4, kupa5, kupa6, kupa7, kupa8, kupa9]
        
        
        
        counter = 10
        timerLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.22, target: self, selector: #selector(hideKupa), userInfo: nil, repeats: true)
        
        hideKupa()
        
    }
    
    @objc func hideKupa() {
        
        for kupa in kupaArray {
            kupa.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(kupaArray.count - 1)))
        kupaArray[random].isHidden = false
    }
    
    
    
    
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    
    @objc func countDown() {
        
        counter -= 1
        timerLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for kupa in kupaArray {
                kupa.isHidden = true
            }
            
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timerLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.22, target: self, selector: #selector(self.hideKupa), userInfo: nil, repeats: true)
                
            }
            
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true)
        }
        
    }

   

}
