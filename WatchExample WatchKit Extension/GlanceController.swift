//
//  GlanceController.swift
//  WatchExample
//
//  Created by Bob Pascazio on 12/17/15.
//  Copyright © 2015 Bytefly, Inc. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class GlanceController: WKInterfaceController, WCSessionDelegate {

    @IBOutlet var bigNumber: WKInterfaceLabel!
    
    var session: WCSession? {
        didSet {
            if let session = session {
                session.delegate = self
                session.activateSession()
            }
        }
    }
    
    override func didAppear() {
        super.didAppear()
        
        if  WCSession.isSupported() {
            session = WCSession.defaultSession()
        
            session!.sendMessage(["reference":"123"], replyHandler: { (response) -> Void in
                
                if let someData = response["someData"] as? String {
                    self.bigNumber?.setText(someData)
                }
                
            }, errorHandler: { (error) -> Void in
                
                print("error \(error)")
            })
            
        }
        
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Create a timer to refresh the time every second
        
        // Call the parent application from Apple Watch
        
        // values to pass
        //Swift

//        let timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateClocks"), userInfo: nil, repeats: true)
 //       timer.fire()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func updateClocks() {
        let time: NSDate = NSDate()
        
        let formatter:NSDateFormatter = NSDateFormatter();
        let timeZone = NSTimeZone(name: "UTC")
        formatter.timeZone = timeZone
        formatter.dateFormat = "ss"

        let formattedString = formatter.stringFromDate(time)
        self.bigNumber?.setText(formattedString)
        
    }

}
