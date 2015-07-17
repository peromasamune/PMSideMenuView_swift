//
//  AppDelegate.swift
//  PMSideMenuView_Demo
//
//  Created by Taku Inoue on 2015/02/13.
//  Copyright (c) 2015年 Taku Inoue. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PMSideMenuViewControllerDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        window = UIWindow(frame: UIScreen.mainScreen().bounds)

        var viewController = PMSideMenuViewController()
        viewController.delegate = self
        viewController.currentSideMenuIndex = 1

        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

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
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK : - PMSideMenuViewControllerDelegate

    func PMSideMenuViewNumberOfSideMenuListItems() -> NSInteger {
        return 4
    }

    func PMSideMenuListItemAtIndex(index: NSInteger) -> PMSideMenuListItem? {

        if (index == 0){
            var item : PMSideMenuListItem = PMSideMenuListItem.itemWith("PMSideMenuView", image: "icon.jpg")
            item.type = PMSideMenuListItemType.CircleImage
            item.cellHeight = 200;
            return item
        }

        if (index == 1){
            return PMSideMenuListItem.itemWith("Menu 1", image: "menu")
        }

        if (index == 2){
            return PMSideMenuListItem.itemWith("Menu 2", image: "menu")
        }

        if (index == 3){
            return PMSideMenuListItem.itemWith("Menu 3", image: "menu")
        }

        return nil
    }

    func PMSideMenuViewControllerTransitionViewControllerWhenSelectedItemAtIndex(viewController: PMSideMenuViewController, index: NSInteger) -> PMSideMenuBaseViewController? {

        if (index == 0){
            return nil
        }

        var itemViewController = ViewController()
        itemViewController.title = "Menu \(index)"

        return itemViewController
    }
}

