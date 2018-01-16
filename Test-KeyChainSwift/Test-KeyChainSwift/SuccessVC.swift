//
//  SuccessVC.swift
//  Test-KeyChainSwift
//
//  Created by Phyllis Wong on 1/15/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

// Success View Controller
class SuccessVC: UIViewController {
    
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func playButtonPressed(_ sender: UIButton) {
        // Fetch the sound data set.
        
        if let asset = NSDataAsset(name: "DogBark") {
            
            do {
                
                // Use NSDataAssets's data property to access the audio file atored in DogBark.
                player = try AVAudioPlayer(data: asset.data, fileTypeHint: ".mp3")
                
                // Play the above sound file
                player?.play()
                
            } catch let error as NSError {
                // Should print...
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
    }
    
    
}
