//
//  ViewController.swift
//  memory
//
//  Created by Antonio Giaquinto on 10/02/2018.
//  Copyright © 2018 Antonio Giaquinto. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet var numberButton: [UIButton]!
    
    var soundPlayer:AVAudioPlayer!
    
    var playlist = [Int]()
    var currentItem = 0
    var numberOfTaps = 0
    var readyForUser = false
    
    var games = 0
    var numberOfElements = 2
    var point = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudioFiles()
        let randomNumber = Int(arc4random_uniform(9) + 1)
        playlist.append(randomNumber)
    }
    
    func setupAudioFiles (){
        debugPrint("Steup Done")
        let soundFilePath = Bundle.main.path(forResource: "1", ofType: "wav")
        let soundFileURL = NSURL(fileURLWithPath: soundFilePath!)
        
        do {
            try soundPlayer = AVAudioPlayer(contentsOf: soundFileURL as URL)
        }catch {
            debugPrint(error)
        }
        
        soundPlayer.delegate = self

        soundPlayer.numberOfLoops = 0
    }
    
    @IBAction func numberButtonPressed(_ sender: Any) {
        
        if readyForUser {
            let button = sender as! UIButton
            
            switch button.tag {
            case 1:
                debugPrint("BUTTON 1 Action")
                
                soundPlayer.play()
                highlightButtonWithTag(tag: 1)
                checkIfCorrect(buttonPressed: 1)
                break
            case 2:
                debugPrint("BUTTON 2 Action")
                
                soundPlayer.play()
                highlightButtonWithTag(tag: 2)
                checkIfCorrect(buttonPressed: 2)
                break
            case 3:
                debugPrint("BUTTON 3 Action")
                
                soundPlayer.play()
                highlightButtonWithTag(tag: 3)
                checkIfCorrect(buttonPressed: 3)
                break
            case 4:
                debugPrint("BUTTON 4 Action")
                
                soundPlayer.play()
                highlightButtonWithTag(tag: 4)
                checkIfCorrect(buttonPressed: 4)
                break
            case 5:
                debugPrint("BUTTON 5 Action")
                
                soundPlayer.play()
                highlightButtonWithTag(tag: 5)
                checkIfCorrect(buttonPressed: 5)
                break
            case 6:
                debugPrint("BUTTON 6 Action")
                
                soundPlayer.play()
                highlightButtonWithTag(tag: 6)
                checkIfCorrect(buttonPressed: 6)
                break
            case 7:
                debugPrint("BUTTON 7 Action")
                
                soundPlayer.play()
                highlightButtonWithTag(tag: 7)
                checkIfCorrect(buttonPressed: 7)
                break
            case 8:
                debugPrint("BUTTON 8 Action")
                
                soundPlayer.play()
                highlightButtonWithTag(tag: 8)
                checkIfCorrect(buttonPressed: 8)
                break
            case 9:
                debugPrint("BUTTON 9 Action")
                
                soundPlayer.play()
                highlightButtonWithTag(tag: 9)
                checkIfCorrect(buttonPressed: 9)
                break
            default:
                break
            }
        }
    }
    
    func checkIfCorrect (buttonPressed:Int) {
        if buttonPressed == playlist[numberOfTaps] {
            if numberOfTaps == playlist.count - 1 { // we have arrived at the last item of the playlist
                debugPrint("Checked")
                point += 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.playlist.removeAll()
                    self.games += 1
                    debugPrint("games in check \(self.games)")
                    self.nextRound()
                    debugPrint("Next Round")
                }
                return
            }
            debugPrint("AFTER DISPATCH")
            numberOfTaps += 1
        }else{ // Error
            //resetGame()
            playlist.removeAll()
            games += 1
            debugPrint("games in check \(games)")
            nextRound()
        }
    }
    
    func resetGame() {
        point = 0
        readyForUser = false
        numberOfTaps = 0
        currentItem = 0
        playlist = []
        startGameButton.isHidden = false
        disableButtons()
    }
    
    func nextRound() {
        if games < 2 {
            debugPrint("Round \(games)")
            debugPrint("primo if")
            sequenceGeneration()
        } else if games < 4 {
            if games == 2 {
                numberOfElements += 1
            }
            debugPrint("Round \(games)")
            debugPrint("secondo if")
            sequenceGeneration()
        } else if games < 6 {
            if games == 4 {
                numberOfElements += 1
            }
            debugPrint("Round \(games)")
            sequenceGeneration()
        } else if games < 8 {
            if games == 6 {
                numberOfElements += 1
            }
            debugPrint("Round \(games)")
            sequenceGeneration()
        } else if games < 10 {
            if games == 8 {
                numberOfElements += 1
            }
            debugPrint("Round \(games)")
            sequenceGeneration()
        } else if games < 12 {
            if games == 10 {
                numberOfElements += 1
            }
            debugPrint("Round \(games)")
            sequenceGeneration()
        } else if games < 14 {
            if games == 12 {
                numberOfElements += 1
            }
            debugPrint("Round \(games)")
            sequenceGeneration()
        } else if games < 16 {
            if games == 14 {
                numberOfElements += 1
            }
            debugPrint("Round \(games)")
            sequenceGeneration()
        } else {
            resetGame()
        }
    }
    
    func sequenceGeneration() {
        readyForUser = false
        numberOfTaps = 0
        currentItem = 0
        disableButtons()
        
        for i in 0...numberOfElements - 1 {
            let randomNumber = Int(arc4random_uniform(9) + 1)
            playlist.insert(randomNumber, at: i)
        }
        
        debugPrint("noe \(numberOfElements)")
        debugPrint(playlist)
        
        playNextItem()
        
        print(games)
    }
    
    @IBAction func startGame(_ sender: Any) {
        debugPrint("PRESS START")
        disableButtons()
        
        let randomNumber = Int(arc4random_uniform(9) + 1)
        playlist.append(randomNumber)
        
        startGameButton.isHidden = true
        playNextItem()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if currentItem <= playlist.count - 1 {
            playNextItem()
        }else{
            readyForUser = true
            resetButtonHighlights()
            enableButtons()
        }
    }
    
    func playNextItem () {
        let selectedItem = playlist[currentItem]
        
        switch selectedItem {
        case 1:
            debugPrint("BUTTON 1 Play")
            
            highlightButtonWithTag(tag: 1)
            soundPlayer.play()
            break
        case 2:
            debugPrint("BUTTON 2 Play")
            
            highlightButtonWithTag(tag: 2)
            soundPlayer.play()
            break
        case 3:
            debugPrint("BUTTON 3 Play")
            
            highlightButtonWithTag(tag: 3)
            soundPlayer.play()
            break
        case 4:
            debugPrint("BUTTON 4 Play")
            
            highlightButtonWithTag(tag: 4)
            soundPlayer.play()
            break
        case 5:
            debugPrint("BUTTON 5 Play")
            
            highlightButtonWithTag(tag: 5)
            soundPlayer.play()
            break
        case 6:
            debugPrint("BUTTON 6 Play")
            
            highlightButtonWithTag(tag: 6)
            soundPlayer.play()
            break
        case 7:
            debugPrint("BUTTON 7 Play")
            
            highlightButtonWithTag(tag: 7)
            soundPlayer.play()
            break
        case 8:
            debugPrint("BUTTON 8 Play")
            
            highlightButtonWithTag(tag: 8)
            soundPlayer.play()
            break
        case 9:
            debugPrint("BUTTON 9 Play")
            
            highlightButtonWithTag(tag: 9)
            soundPlayer.play()
            break
        default:
            break;
        }
        currentItem += 1
    }
    
    func highlightButtonWithTag (tag:Int) {
        switch tag {
        case 1:
            debugPrint("BUTTON 1 Highlight")
            
            resetButtonHighlights()
            numberButton[tag - 1].setImage(#imageLiteral(resourceName: "h"), for: .normal)
        case 2:
            debugPrint("BUTTON 2 Highlight")
            
            resetButtonHighlights()
            numberButton[tag - 1].setImage(#imageLiteral(resourceName: "h"), for: .normal)
        case 3:
            debugPrint("BUTTON 3 Highlight")
            
            resetButtonHighlights()
            numberButton[tag - 1].setImage(#imageLiteral(resourceName: "h"), for: .normal)
        case 4:
            debugPrint("BUTTON 4 Highlight")
            
            resetButtonHighlights()
            numberButton[tag - 1].setImage(#imageLiteral(resourceName: "h"), for: .normal)
        case 5:
            debugPrint("BUTTON 5 Highlight")
            
            resetButtonHighlights()
            numberButton[tag - 1].setImage(#imageLiteral(resourceName: "h"), for: .normal)
        case 6:
            debugPrint("BUTTON 6 Highlight")
            
            resetButtonHighlights()
            numberButton[tag - 1].setImage(#imageLiteral(resourceName: "h"), for: .normal)
        case 7:
            debugPrint("BUTTON 7 Highlight")
            
            resetButtonHighlights()
            numberButton[tag - 1].setImage(#imageLiteral(resourceName: "h"), for: .normal)
        case 8:
            debugPrint("BUTTON 8 Highlight")
            
            resetButtonHighlights()
            numberButton[tag - 1].setImage(#imageLiteral(resourceName: "h"), for: .normal)
        case 9:
            debugPrint("BUTTON 9 Highlight")
            
            resetButtonHighlights()
            numberButton[tag - 1].setImage(#imageLiteral(resourceName: "h"), for: .normal)
        default:
            break
        }
    }
    
    func resetButtonHighlights () {
        debugPrint("RESET HIGHLITS")
        numberButton[0].setImage(#imageLiteral(resourceName: "nh"), for: .normal)
        numberButton[1].setImage(#imageLiteral(resourceName: "nh"), for: .normal)
        numberButton[2].setImage(#imageLiteral(resourceName: "nh"), for: .normal)
        numberButton[3].setImage(#imageLiteral(resourceName: "nh"), for: .normal)
        numberButton[4].setImage(#imageLiteral(resourceName: "nh"), for: .normal)
        numberButton[5].setImage(#imageLiteral(resourceName: "nh"), for: .normal)
        numberButton[6].setImage(#imageLiteral(resourceName: "nh"), for: .normal)
        numberButton[7].setImage(#imageLiteral(resourceName: "nh"), for: .normal)
        numberButton[8].setImage(#imageLiteral(resourceName: "nh"), for: .normal)
    }
    
    func disableButtons () {
        for button in numberButton {
            button.isUserInteractionEnabled = false
        }
    }
    
    func enableButtons () {
        for button in numberButton {
            button.isUserInteractionEnabled = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

