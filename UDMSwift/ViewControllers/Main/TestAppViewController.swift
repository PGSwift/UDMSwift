//
//  TestAppViewController.swift
//  UDMSwift
//
//  Created by OSXVN on 8/21/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import Foundation
import Player

class TestAppViewController: UIViewController, PlayerDelegate {
    
    private var player: Player!
    
    let videoUrl = NSURL(string: "https://v.cdn.vine.co/r/videos/AA3C120C521177175800441692160_38f2cbd1ffb.1.5.13763579289575020226.mp4")!
    // MARK: - custom view ---------xxxxxxxxxx---------
/*   private static let NibName: String = "CustomView"
    
    static func createInstance() -> CustomView {
        return NSBundle.mainBundle().loadNibNamed(nibName, owner: nil, options: nil)[0] as! CustomView
    } */
    
    // MARK: - Name Notificatoin ---------xxxxxxxxxx---------
    func demoPostNotification() {
        NSNotificationCenter.defaultCenter().postNotificationName(DetailListViewController.Notification.updateDraft, object: nil)
    }
    
    struct Notification {
        static let updateDraft = "UpdateDraftOfConversation"
    }
    func demoaddObserverNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TestAppViewController.demoPostNotification), name: Notification.updateDraft, object: nil)
    }

    private var handlerNotificationABC: AnyObject?
    
    func registerNotification() {
       handlerNotificationABC = NSNotificationCenter.defaultCenter().addObserverForName(Notification.updateDraft, object: self, queue: nil, usingBlock: { (notification)  in
        println("Class: \(NSStringFromClass(self.dynamicType)) recived: \(notification.name)")
       })
    }
    
    func deregisterNofitication() {
        if let handlerNotificationABC = handlerNotificationABC {
            NSNotificationCenter.defaultCenter().removeObserver(handlerNotificationABC)
        }
    }
    
    deinit {
        deregisterNofitication()
    }
    // ---------xxxxxxxxxx---------

    // MAKR: - Using lazy 
    lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(), forState: .Normal)
        button.tintColor = UIColor.lightGrayColor()
        button.tintAdjustmentMode = .Normal
        button.addTarget(self, action: #selector(TestAppViewController.demoPostNotification), forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }()
    // ---------xxxxxxxxxx---------
    
    
    @IBAction func demoButton(sender: AnyObject) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UDMService.getListCategory(with: <#T##[String : String]?#>, Completion: <#T##((data: [String : AnyObject], success: Bool) -> Void)?##((data: [String : AnyObject], success: Bool) -> Void)?##(data: [String : AnyObject], success: Bool) -> Void#>)
        registerNotification()
        
        self.player = Player()
        self.player.delegate = self
        self.player.view.frame = self.view.bounds
        
        self.addChildViewController(self.player)
        self.view.addSubview(self.player.view)
        self.player.didMoveToParentViewController(self)
        
        self.player.setUrl(videoUrl)
        
        self.player.playbackLoops = true
        
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGestureRecognizer(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.player.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @IBAction func postNotification(sender: AnyObject) {
       // self.presentViewController(DetailListViewController.createInstance(), animated: true, completion: nil)
    //NSNotificationCenter.defaultCenter().postNotificationName(Notification.updateDraft, object: self)
        // alert 
//        UDMAlert.alert(title: "VINH DEMO", message: "Sorry everyone", dismissTitle: "Thanks all", inViewController: self) { 
//            println("action run")
//        }
//        UDMAlert.textInput(title: "VINH", placeholder: "input name", oldText: "old text", dismissTitle: "OK", inViewController: self) { (text) in
//            self.showText(text)
//        }
        UDMHUD.showActivityIndicator()
        
    }
    
    func handleTapGestureRecognizer(gestureRecognizer: UITapGestureRecognizer) {
        switch (self.player.playbackState.rawValue) {
        case PlaybackState.Stopped.rawValue:
            self.player.playFromBeginning()
        case PlaybackState.Paused.rawValue:
            self.player.playFromCurrentTime()
        case PlaybackState.Playing.rawValue:
            self.player.pause()
        case PlaybackState.Failed.rawValue:
            self.player.pause()
        default:
            self.player.pause()
        }
    }
    
    // MARK: PlayerDelegate
    
    func playerReady(player: Player) {
    }
    
    func playerPlaybackStateDidChange(player: Player) {
    }
    
    func playerBufferingStateDidChange(player: Player) {
    }
    
    func playerPlaybackWillStartFromBeginning(player: Player) {
    }
    
    func playerPlaybackDidEnd(player: Player) {
    }
    
    func playerCurrentTimeDidChange(player: Player) {
    }
    
    func playerWillComeThroughLoop(player: Player) {
        
    }

    
    func showText(txt: String) -> Void {
        println("result = \(txt)")
    }
    
    override func viewWillAppear(animated: Bool) {
        //NSNotificationCenter.defaultCenter().postNotification("Demo where post notification in viewcontroller")  // Remove init Notification
    }
    
    override func viewWillDisappear(animated: Bool) {
        if self.navigationController?.viewControllers.contains(self) == false {
            NSNotificationCenter.defaultCenter().removeObserver(self)
        }
    }
    
}
