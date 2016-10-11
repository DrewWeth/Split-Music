//
//  FirstViewController.swift
//  SplytMusic
//
//  Created by AGW on 10/8/16.
//  Copyright © 2016 DrewWeth. All rights reserved.
//

import UIKit
import MediaPlayer

class FirstViewController: UIViewController, UIWebViewDelegate, AVAudioPlayerDelegate,MPMediaPickerControllerDelegate, UINavigationControllerDelegate {
    
    var activeSelector:Int!
    
    var picker:MPMediaPickerController?
    @IBOutlet weak var buttonSelectRight: UIButton!
    @IBOutlet weak var buttonPlayRight: UIButton!
    @IBOutlet weak var rightLabelTwo: UILabel!
    @IBOutlet weak var rightLabelOne: UILabel!
    @IBOutlet weak var sliderVolumeRight: UISlider!
    @IBOutlet weak var sliderProgressRight: UISlider!
    @IBOutlet weak var labelDurationRight: UILabel!
    @IBOutlet weak var labelCurrentTimeRight: UILabel!
    @IBOutlet weak var imageRight: UIImageView!
    
    @IBOutlet weak var imageLeft: UIImageView!
    @IBOutlet weak var sliderVolumeLeft: UISlider!
    @IBOutlet weak var leftLabelTwo: UILabel!
    @IBOutlet weak var leftLabelOne: UILabel!
    @IBOutlet weak var buttonPlay: UIButton!
    @IBOutlet weak var buttonSelectOne: UIButton!
    @IBOutlet weak var sliderProgressLeft: UISlider!
    @IBOutlet weak var labelDurationLeft: UILabel!
    @IBOutlet weak var labelCurrentTimeLeft: UILabel!
    
    
    @IBOutlet weak var bgImage: UIImageView!
    
    var timerLeft:Timer!
    var timerRight:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activeSelector = 0
    
//        webOne.loadRequest(URLRequest(url: URL(string: "https://www.youtube.com/watch?v=lDKJ29357FU")!))
//        webTwo.loadRequest(URLRequest(url: URL(string: "https://www.youtube.com/watch?v=n6RTF4OPzf8")!))
        
        updateView()
        
        // Visual edits
        let newSize = CGSize(width: 10, height: 10)
        sliderProgressRight.setThumbImage(imageWithImage(image: UIImage(), scaledToSize: newSize), for: UIControlState.normal)
        sliderProgressLeft.setThumbImage(imageWithImage(image: UIImage(), scaledToSize: newSize), for: UIControlState.normal)
        
        bgImage.frame = view.bounds
        view.backgroundColor = UIColor.clear
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
//        blurEffectView.autoresizingMask 
//        view.insertSubview(blurEffectView, at: view.subviews.count - 1)
        view.insertSubview(blurEffectView, at: 1)
    }
    
    @IBAction func buttonPlayPressed(_ sender: UIButton) {
        // Left side
        if MusicPlayers.musicStates[0].player.isPlaying{
            MusicPlayers.musicStates[0].player.pause()
            
            MusicPlayers.musicStates[0].isPlaying = false
            
            updatePlayButton(sender: sender, state: MusicPlayers.musicStates[0])
            print("Left paused")
        }else{
            MusicPlayers.musicStates[0].player.play()
            timerLeft = Timer.scheduledTimer(timeInterval: 0.23, target: self, selector: #selector(FirstViewController.updateProgressBars), userInfo: nil, repeats: true)
        
            MusicPlayers.musicStates[0].isPlaying = true
            updatePlayButton(sender: sender, state: MusicPlayers.musicStates[0])
            print("Left play")
        }
    }
    
    @IBAction func sliderLeftVolumeChanged(_ sender: UISlider) {
        MusicPlayers.musicStates[0].volume = sender.value
        MusicPlayers.musicStates[0].player.volume = sender.value
    }
    
    @IBAction func sliderRightVolumeChanged(_ sender: UISlider) {
        MusicPlayers.musicStates[1].volume = sender.value
        MusicPlayers.musicStates[1].player.volume = sender.value
    }
    
    
    @IBAction func buttonRightPlayPressed(_ sender: UIButton) {
        // Right side
        if MusicPlayers.musicStates[1].player.isPlaying{
            MusicPlayers.musicStates[1].player.pause()
            MusicPlayers.musicStates[1].isPlaying = false
            updatePlayButton(sender: sender, state: MusicPlayers.musicStates[1])
            
            print("Right paused")
        }else{
            MusicPlayers.musicStates[1].player.play()
            timerRight = Timer.scheduledTimer(timeInterval: 0.23, target: self, selector: #selector(FirstViewController.updateProgressBars), userInfo: nil, repeats: true)
            MusicPlayers.musicStates[1].isPlaying = true
            updatePlayButton(sender: sender, state: MusicPlayers.musicStates[1])

            print("Right play")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func displayMediaPicker(){
        let mediaPicker:MPMediaPickerController? = MPMediaPickerController(mediaTypes: MPMediaType.anyAudio)
        if let picker = mediaPicker{
            print("Success media picker")
            picker.showsCloudItems = false
            picker.delegate = self
            picker.allowsPickingMultipleItems = false
            picker.prompt = "Select a song"
            
//            view.addSubview(picker.view)
            present(picker, animated: true, completion: nil)
        }else{
            print("ERR: Media picker not working")
        }
    }
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        mediaPicker.dismiss(animated: true, completion: nil)
    }

    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        print("Media returned!")
        mediaPicker.dismiss(animated: true, completion: nil)
        for item in mediaItemCollection.items as [MPMediaItem]{
            print(item.value(forProperty: MPMediaItemPropertyTitle))
            print(item.value(forProperty: MPMediaItemPropertyAssetURL) as? NSURL)
            loadItunesSong(index: activeSelector, item: item)
            updateView()
            
            if let url = item.value(forProperty: MPMediaItemPropertyAssetURL){
                do{
                    try MusicPlayers.musicStates[activeSelector].player = AVAudioPlayer(contentsOf: url as! URL)
                    MusicPlayers.musicStates[activeSelector].player.pan = MusicPlayers.musicStates[activeSelector].pan
                    if MusicPlayers.musicStates[activeSelector].isPlaying == true {
                        MusicPlayers.musicStates[activeSelector].player.play()
                    }
                    MusicPlayers.musicStates[activeSelector].player.volume = MusicPlayers.musicStates[activeSelector].volume
                }catch{
                    print("Error loading music to left player")
                }
            }else{
                print("ERR: No url for media")
            }
        }
    }
    
    @IBAction func buttonSelectRightPressed(_ sender: AnyObject) {
        displayMediaPicker()
        activeSelector = 1
    }
    
    @IBAction func buttonSelectOnePressed(_ sender: AnyObject) {
        displayMediaPicker()
        activeSelector = 0
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        let index = determineWhichPlayer(player: player)
        print("SONG WITH INDEX \(index) HAS ENDED")
        MusicPlayers.musicStates[index].isPlaying = false
        MusicPlayers.musicStates[index].song = nil
    }
    
    func updatePlayButton(sender:UIButton, state:MusicState){
        if state.isPlaying == true{
            sender.setTitle("Pause", for: UIControlState.normal)
        }else{
            sender.setTitle("Play", for: UIControlState.normal)
        }
    }
    
    @IBAction func sliderProgressLeftChanged(_ sender: UISlider) {
        
    }
    
    @IBAction func sliderProgressRightChanged(_ sender: UISlider) {
    }
    
    func updateProgressBars(){
        var player = MusicPlayers.musicStates[0].player as! AVAudioPlayer
        let left = player.currentTime / player.duration
        sliderProgressLeft.setValue(Float(left), animated: false)
        labelCurrentTimeLeft.text = stringFromTimeInterval(interval: player.currentTime)
        
        player = MusicPlayers.musicStates[1].player
        let right = player.currentTime / player.duration
        sliderProgressRight.setValue(Float(right), animated: false)
        labelCurrentTimeRight.text = stringFromTimeInterval(interval: player.currentTime)
    }
    
    func stringFromTimeInterval(interval:TimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60)
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func updateView(){
        var state = MusicPlayers.musicStates[0]
        labelDurationLeft.text = stringFromTimeInterval(interval: state.player.duration)
        if state.song != nil{
            leftLabelOne.text = state.song!.name ?? "Unknown"
            leftLabelTwo.text = state.song!.artist ?? "Unknown"
            imageLeft.image = state.song!.albumArt ?? UIImage()
        }
        
        state = MusicPlayers.musicStates[1]
        labelDurationRight.text = stringFromTimeInterval(interval: state.player.duration)
        if state.song != nil{
            rightLabelOne.text = state.song!.name ?? "Unknown"
            rightLabelTwo.text = state.song!.artist ?? "Unknown"
            imageRight.image = state.song?.albumArt
         }
    }
    
    func loadItunesSong(index:Int, item:MPMediaItem){
        let title:String = (item.value(forKey: MPMediaItemPropertyTitle) as? String)!
        let artist = item.value(forKey: MPMediaItemPropertyArtist) as? String
        let genre = item.value(forKey: MPMediaItemPropertyGenre)
        let art:MPMediaItemArtwork? = item.value(forKey: MPMediaItemPropertyArtwork) as? MPMediaItemArtwork
        
        let image:UIImage? = art?.image(at: (art?.bounds.size)!)
        
        let album = item.value(forKey: MPMediaItemPropertyAlbumTitle)
        let song = Song(name: title, duration: 69, artist: artist, genre: genre as! String?, album: album as! String?, albumArt: image)
        MusicPlayers.musicStates[index].song = song
        print(song)
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}

