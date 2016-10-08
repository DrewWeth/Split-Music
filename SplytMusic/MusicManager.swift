//
//  MusicManager.swift
//  SplytMusic
//
//  Created by AGW on 10/8/16.
//  Copyright © 2016 DrewWeth. All rights reserved.
//

import Foundation
import AVFoundation
import AudioToolbox

func playMusic(){
    let leftPath:String? = Bundle.main.path(forResource: "daft_punk", ofType: "mp3")
    if leftPath == nil{
        print("ERR: Resource path nil")
    }
    MusicState.leftPath = leftPath
    
    let rightPath:String? = Bundle.main.path(forResource: "st_lucia", ofType: "mp3")
    if rightPath == nil{
        print("ERR: Resource path nil")
    }
    MusicState.rightPath = rightPath
    
    print("Valid paths:\nLeft: \(MusicState.leftPath)\nRight:\(MusicState.rightPath)")
    
    // Left side
    do{
        MusicState.leftPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: leftPath!))
        MusicState.leftPlayer.numberOfLoops = -1
        MusicState.leftPlayer.pan = -1.0
        MusicState.leftPlayer.play()
        print("Playing left music...")
    }catch{
        print("ERR: Caught left error")
    }
    
    // Right side
    do{
        MusicState.rightPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: rightPath!))
        MusicState.rightPlayer.numberOfLoops = -1
        MusicState.rightPlayer.pan = 1.0
        MusicState.rightPlayer.play()
        print("Playing right music...")
    }catch{
        print("ERR: Caught right error")
    }
}
