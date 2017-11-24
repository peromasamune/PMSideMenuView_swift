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

    func applicationDidFinishLaunching(_ application: UIApplication) {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let viewController = PMSideMenuViewController()
        viewController.delegate = self
        viewController.currentSideMenuIndex = 1
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }

    // MARK : - PMSideMenuViewControllerDelegate

    func PMSideMenuViewNumberOfSideMenuListItems() -> NSInteger {
        return 4
    }

    func PMSideMenuListItemAtIndex(index: NSInteger) -> PMSideMenuListItem? {

        if (index == 0){
            let item : PMSideMenuListItem = PMSideMenuListItem.itemWith(title: "PMSideMenuView", image: "icon.jpg")
            item.type = PMSideMenuListItemType.CircleImage
            item.cellHeight = 200;
            return item
        }

        if (index == 1){
            return PMSideMenuListItem.itemWith(title: "Menu 1", image: "menu")
        }

        if (index == 2){
            return PMSideMenuListItem.itemWith(title: "Menu 2", image: "menu")
        }

        if (index == 3){
            return PMSideMenuListItem.itemWith(title: "Menu 3", image: "menu")
        }

        return nil
    }

    func PMSideMenuViewControllerTransitionViewControllerWhenSelectedItemAtIndex(viewController: PMSideMenuViewController, index: NSInteger) -> PMSideMenuBaseViewController? {

        if (index == 0){
            return nil
        }

        let itemViewController = ViewController()
        itemViewController.title = "Menu \(index)"

        return itemViewController
    }
}

