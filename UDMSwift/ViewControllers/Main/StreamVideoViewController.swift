//
//  StreamVideoViewController.swift
//  UDMSwift
//
//  Created by OSXVN on 10/4/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit
import R5Streaming

class StreamVideoViewController: UIViewController, ViewControllerProtocol {
    // MARK: - Properties
    
    var currentView : R5VideoViewController? = nil
    var publishStream : R5Stream? = nil
    var subscribeStream : R5Stream? = nil
    
    // MARK: Initialzation
    static func createInstance() -> UIViewController {
        return MainStoryboard.instantiateViewControllerWithIdentifier("StreamVideoViewControllerID") as! StreamVideoViewController
    }
    
    func initData() {
        
    }
    
    func configItems() {
        getConfig()
        
        AVAudioSession.sharedInstance().requestRecordPermission { (gotPerm: Bool) -> Void in
        };
        
        r5_set_log_level((Int32)(r5_log_level_debug.rawValue))
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        configItems()
        
        setupDefaultR5VideoViewController()
        
        // Set up the configuration
        let config = getConfig()
        // Set up the connection and stream
        let connection = R5Connection(config: config)
        
        setupPublisher(connection)
        // show preview and debug info
        
        self.currentView!.attachStream(publishStream!)
        
        self.publishStream!.publish(R5StreamingManager.shareInstance.streamName1, type: R5RecordTypeLive)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: - R5StreamDelegate
extension StreamVideoViewController: R5StreamDelegate {
    
    func onR5StreamStatus(stream: R5Stream!, withStatus statusCode: Int32, withMessage msg: String!) {
        NSLog("Status: %s ", r5_string_for_status(statusCode))
//        let s =  String(format: "Status: %s (%@)",  r5_string_for_status(statusCode), msg)
//        
//        ALToastView.toastInView(self.view, withText:s)
    }
    
    func getConfig()->R5Configuration{
        // Set up the configuration
        let config = R5Configuration()
        config.host = R5StreamingManager.shareInstance.hostName
        config.port = R5StreamingManager.shareInstance.port
        config.contextName = R5StreamingManager.shareInstance.context
        config.`protocol` = 1;
        config.buffer_time = R5StreamingManager.shareInstance.buffer_time
        return config
    }
    
    func setupPublisher(connection: R5Connection){
        
        self.publishStream = R5Stream(connection: connection)
        self.publishStream!.delegate = self
        
        if(R5StreamingManager.shareInstance.onVideo){
            // Attach the video from camera to stream
            let videoDevice = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo).last as? AVCaptureDevice
            
            let camera = R5Camera(device: videoDevice, andBitRate: Int32(R5StreamingManager.shareInstance.bitrate))
            camera.width = Int32(R5StreamingManager.shareInstance.camera_width)
            camera.height = Int32(R5StreamingManager.shareInstance.camera_height)
            camera.orientation = 90
            self.publishStream!.attachVideo(camera)
        }
        if(R5StreamingManager.shareInstance.onAudio){
            // Attach the audio from microphone to stream
            let audioDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeAudio)
            let microphone = R5Microphone(device: audioDevice)
            microphone.bitrate = 32
            microphone.device = audioDevice;
            NSLog("Got device %@", audioDevice)
            self.publishStream!.attachAudio(microphone)
        }
    }
    func setupDefaultR5VideoViewController() -> R5VideoViewController{
        
        let r5View : R5VideoViewController = getNewR5VideoViewController(self.view.frame);
        self.addChildViewController(r5View);
        
        
        view.addSubview(r5View.view)
        
        r5View.showPreview(true)
        
        r5View.showDebugInfo(R5StreamingManager.shareInstance.isDebugView)
        
        currentView = r5View;
        
        return currentView!
    }
    
    func getNewR5VideoViewController(rect : CGRect) -> R5VideoViewController{
        
        let view : UIView = UIView(frame: rect)
        
        let r5View : R5VideoViewController = R5VideoViewController();
        r5View.view = view;
        
        return r5View;
    }

    func closeStream(){
        
        NSLog("closing view")
        
        if( self.publishStream != nil ){
            self.publishStream!.stop()
        }
        
        if( self.subscribeStream != nil ){
            self.subscribeStream!.stop()
        }
        
        self.removeFromParentViewController()
    }
}
