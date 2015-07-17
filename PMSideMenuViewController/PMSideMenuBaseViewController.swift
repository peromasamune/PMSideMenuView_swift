//
//  PMSideMenuBaseViewController.swift
//  PMSideMenuView_Demo
//
//  Created by Taku Inoue on 2015/02/13.
//  Copyright (c) 2015年 Taku Inoue. All rights reserved.
//

import UIKit

class PMSideMenuBaseViewController: UIViewController {

    weak var sideMenu : PMSideMenuViewController?

    // MARK : - Initializer

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.view.backgroundColor = UIColor.whiteColor()

        if self.navigationController?.viewControllers.count <= 1 {
            let sideMenuButton : UIBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.Plain, target: self, action:"toggleSideMenuButtonDidPush:")
            self.navigationItem.leftBarButtonItem = sideMenuButton
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK : - Button Actions
    
    func toggleSideMenuButtonDidPush(sender : UIButton){
        sideMenu?.toggleSideMenu()
    }

}
