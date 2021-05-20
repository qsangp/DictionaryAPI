//
//  ViewController.swift
//  dictionaryGetAPI
//
//  Created by ielts-vuive on 15/05/2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITextFieldDelegate, DictionaryDelegate {
    
    var dictionaryManager = DictionaryManager()

    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var exampleOfWord: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light

        userInput.delegate = self
        dictionaryManager.delegate = self
        
    }

    @IBAction func soundButtonPressed(_ sender: UIButton) {
        let url = NSURL(string: sourceAudio ?? "")
        do {
              try AVAudioSession.sharedInstance().setCategory(.playback)
                avPlayerItem = AVPlayerItem.init(url: url! as URL)
                avPlayer = AVPlayer.init(playerItem: avPlayerItem)
                avPlayer?.volume = 1.0
                avPlayer?.play()
            
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userInput.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let wordInput = userInput.text {
            dictionaryManager.getUserInput(wordInput: wordInput)
        }
        userInput.text = ""
    }
    
    func updateUI(dictionaryModel: DictionaryModel) {
        DispatchQueue.main.async {
            self.wordLabel.text = dictionaryModel.word
            self.exampleOfWord.text = dictionaryModel.definition
            self.getSourceAudio(dictionaryModel.phoneticsAudio)
        }
    }
    
    var avPlayer: AVPlayer?
    var avPlayerItem: AVPlayerItem?
    
    var sourceAudio: String?
    
    func getSourceAudio(_ source: String) {
        sourceAudio = source
    }

}

