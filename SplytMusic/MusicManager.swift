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

func setupMusic(){
    
    let leftPath:String? = nil
    if leftPath == nil{
        print("ERR: Resource path nil")
    }
    
    let rightPath:String? = nil
    if rightPath == nil{
        print("ERR: Resource path nil")
    }

    
    // Left side
    do{
        
        let song = Song(name: "Unknown Name", duration:nil, artist: "Unknown Artist", genre: nil, album: nil, albumArt: nil)
        let ms = MusicState(player: nil, pan: -1.0, path: leftPath, numberOfLoops: 0, isPlaying:false, volume:0.5, song:song)
//        copyState(sourceState: ms, targetPlayer: nil)
        MusicPlayers.musicStates.append(ms)
        print("Left music set up")
    }catch{
        print("ERR: Caught left error")
    }
    
    // Right side
    do{
        
        let song = Song(name: "Unknown Name", duration: 69, artist: "Unknown Artist", genre: nil, album: nil, albumArt: nil)
        let ms = MusicState(player: nil, pan: 1.0, path: rightPath, numberOfLoops: 0, isPlaying:false, volume:0.5, song:song)
//        copyState(sourceState: ms, targetPlayer: nil)
        MusicPlayers.musicStates.append(ms)
        print("Right music set up")
    }catch{
        print("ERR: Caught right error")
    }
}

func copyState(sourceState:MusicState, targetPlayer:AVAudioPlayer){
    targetPlayer.volume = sourceState.volume
    targetPlayer.pan = sourceState.pan
    targetPlayer.numberOfLoops = sourceState.numberOfLoops
}

func determineWhichPlayer(player:AVAudioPlayer) -> Int{
    for (index, states) in MusicPlayers.musicStates.enumerated(){
        if states.player === player{
            return index
        }
    }
    return -1
}

//func initPlayerStates(){
//    let left = MusicState(player: AVAudioPlayer(), pan: -1.0, path: nil)
//    MusicPlayers.musicStates.append(left)
//    
//    let right = MusicState(player: AVAudioPlayer(), pan: 1.0, path: nil)
//    MusicPlayers.musicStates.append(right)
//}
