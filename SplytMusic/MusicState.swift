//
//  MusicState.swift
//  SplytMusic
//
//  Created by AGW on 10/8/16.
//  Copyright © 2016 DrewWeth. All rights reserved.
//

import Foundation
import AVFoundation
import AudioToolbox
import UIKit

struct MusicState{
    var player:AVAudioPlayer!
    var pan:Float!
    var path:String?
    var numberOfLoops:Int!
    var isPlaying:Bool!
    var volume:Float!
    var song:Song?
//    static var avLeftPlayer:AVPlayer!
}

struct MusicPlayers{
    static var musicStates = [MusicState]()
}

struct Song{
    var name:String?
    var duration:Int?
    var artist:String?
    var genre:String?
    var album:String?
    var albumArt:UIImage?
}
