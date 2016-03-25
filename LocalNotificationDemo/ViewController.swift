//
//  ViewController.swift
//  LocalNotificationDemo
//
//  Created by ying on 16/3/25.
//  Copyright © 2016年 ying. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sendLocalNotification(sender: UIButton) {
        
        var localNotification = UILocalNotification()
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 6)
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        
        localNotification.alertBody = "本地通知来啦"
        localNotification.applicationIconBadgeNumber = 1
        localNotification.soundName = UILocalNotificationDefaultSoundName
        
        localNotification.userInfo = [LocalNotificationIdentifier.kLocationNotificationKey: "觉醒吧，少年"]
        localNotification.category = LocalNotificationIdentifier.kNotificationCategoryIdentifile
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        
    }

    @IBAction func cancelSendLocalNotification(sender: UIButton) {
        for obj in UIApplication.sharedApplication().scheduledLocalNotifications!
        {
            if obj.userInfo!.keys.contains(LocalNotificationIdentifier.kLocationNotificationKey)
            {
                UIApplication.sharedApplication().cancelLocalNotification(obj)
            }
        }
        
    }
    

}

