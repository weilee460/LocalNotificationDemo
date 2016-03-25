//
//  AppDelegate.swift
//  LocalNotificationDemo
//
//  Created by ying on 16/3/25.
//  Copyright © 2016年 ying. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        registerLocalNotification()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func registerLocalNotification()
    {
        //Create action1  for Notification Message
        var localNotificationAction1 = UIMutableUserNotificationAction()
        localNotificationAction1.identifier = LocalNotificationIdentifier.kNotificationActionIdentifileStar
        localNotificationAction1.title = "已阅"
        //when click, handle in background, not in forground.
        localNotificationAction1.activationMode = UIUserNotificationActivationMode.Background
        //set need unlock, then handle
        localNotificationAction1.authenticationRequired = true
        localNotificationAction1.destructive = false
        
        //Create action2  for Notification Message
        var localNotificationAction2 = UIMutableUserNotificationAction()
        localNotificationAction2.identifier = LocalNotificationIdentifier.kNotificationActionIdentifileComment
        localNotificationAction2.title = "评论"
        localNotificationAction2.activationMode = UIUserNotificationActivationMode.Background
        //show input textFeild for user inputing
        localNotificationAction2.behavior = UIUserNotificationActionBehavior.TextInput
        //Set input textField right button title, title is "发送" in default
        localNotificationAction2.parameters = [UIUserNotificationTextInputActionButtonTitleKey: "发表"]
        
        //Create Action category Set
        var category = UIMutableUserNotificationCategory()
        category.identifier = LocalNotificationIdentifier.kNotificationCategoryIdentifile
        category.setActions([localNotificationAction1, localNotificationAction2], forContext: UIUserNotificationActionContext.Minimal)
        var sets: Set = [category]
        
        var settings = UIUserNotificationSettings(forTypes: [UIUserNotificationType.Alert, UIUserNotificationType.Sound, UIUserNotificationType.Badge], categories: sets)
        
    UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
    
        print("\(notification.userInfo!)")
        showAlertView("用户没点击按钮直接点的推送消息进来的/或者该app在前台状态时收到推送消息")
        var badge = UIApplication.sharedApplication().applicationIconBadgeNumber
        badge -= notification.applicationIconBadgeNumber
        badge = badge >= 0 ? badge : 0
        UIApplication.sharedApplication().applicationIconBadgeNumber = badge
    }
    

    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, withResponseInfo responseInfo: [NSObject : AnyObject], completionHandler: () -> Void) {
        
        if identifier == LocalNotificationIdentifier.kNotificationActionIdentifileStar
        {
            showAlertView("点赞")
        }
        else if identifier == LocalNotificationIdentifier.kNotificationActionIdentifileComment
        {
            showAlertView("用户评论为：\(responseInfo[UIUserNotificationActionResponseTypedTextKey])")
        }
        completionHandler()
    }
    
    func showAlertView(message: String) {
        var alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        var action = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        window?.rootViewController?.showDetailViewController(alert, sender: nil)
    }


}

