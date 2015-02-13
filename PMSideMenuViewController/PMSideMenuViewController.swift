//
//  PMSideMenuViewController.swift
//  PMSideMenuView_Demo
//
//  Created by Taku Inoue on 2015/02/13.
//  Copyright (c) 2015年 Taku Inoue. All rights reserved.
//

import UIKit

protocol PMSideMenuViewControllerDelegate {
    func numberOfSideMenuListItems() -> NSInteger
    func sideMenuListItemAtIndex(index : NSInteger) -> Void
    func sideMenuViewControllerTransitionViewControllerWhenSelectedItemAtIndex(viewController : PMSideMenuViewController, index : NSInteger) -> UIViewController
}

private let Animation_Duration : CGFloat = 0.2

class PMSideMenuViewController: UIViewController {

    // MARK : - Properties
    // Public
    var currentSideMenuIndex : NSInteger? = 0
    var delegate : PMSideMenuViewControllerDelegate!

    // Private
    private var contentsNavigationController : UINavigationController?
    private var sideMenuListView : UIView?
    private var gradientView : PMColorGradientView?

    // MARK : - Static Method
    class var sharedController : PMSideMenuViewController{
        get{
            struct Static {
                static var instance : PMSideMenuViewController? = nil
                static var token : dispatch_once_t = 0
            }

            dispatch_once(&Static.token, { () -> Void in
                Static.instance = PMSideMenuViewController()
            })

            return Static.instance!
        }
    }

    // MARK : - Initializer
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.createView()
    }

    func createView(){

        self.gradientView = PMColorGradientView(frame: self.view.frame)
        self.gradientView?.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        self.gradientView?.backgroundColor = UIColor.clearColor()
        self.view.addSubview(self.gradientView!)

        var bulrView = UIToolbar(frame: self.view.frame)
        bulrView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        bulrView.alpha = 0.5
        self.view.addSubview(bulrView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK : - Class Method
    func transitionToSpecificViewControllerFrimSideMenuType(type : NSInteger){

    }

    func setSideMenuHidden(hidden : Bool, animated : Bool){

    }

    func reloadData(){

    }

    //MARK : - Private Method

}
