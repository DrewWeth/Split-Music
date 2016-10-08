//
//  FirstViewController.swift
//  SplytMusic
//
//  Created by AGW on 10/8/16.
//  Copyright © 2016 DrewWeth. All rights reserved.
//

import UIKit
import MediaPlayer

class FirstViewController: UIViewController, UIWebViewDelegate, MPMediaPickerControllerDelegate {
    
    var picker:MPMediaPickerController?
    

    @IBOutlet weak var webOne: UIWebView!
    @IBOutlet weak var webTwo: UIWebView!
    
    var urlLink1:String!
    var urlLink2:String!
    
    var url1:URL!
    var url2:URL!
    
    var req1:URLRequest!
    var req2:URLRequest!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webOne.delegate = self
        webTwo.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.

        self.urlLink1 = ""
        // One More Time
//        self.urlLink2 = "https://www.youtube.com/watch?v=n6RTF4OPzf8"

//        webOne.loadRequest(URLRequest(url: URL(string: "https://www.youtube.com/watch?v=lDKJ29357FU")!))
//        webTwo.loadRequest(URLRequest(url: URL(string: "https://www.youtube.com/watch?v=n6RTF4OPzf8")!))
        
        displayMediaPicker()

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func displayMediaPicker(){
        let mediaPicker:MPMediaPickerController? = MPMediaPickerController(mediaTypes: MPMediaType.anyAudio)
        if let picker = mediaPicker{
            print("Success media picker")
            picker.delegate = self
            picker.prompt = "Select a song"
            view.addSubview(picker.view)
            present(picker, animated: true, completion: nil)
        }else{
            print("ERR: Media picker not working")
        }
        
    }
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        print("Media returned!")
    }

}

