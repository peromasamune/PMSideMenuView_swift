//
//  PMSideMenuViewController.swift
//  PMSideMenuView_Demo
//
//  Created by Taku Inoue on 2015/02/13.
//  Copyright (c) 2015年 Taku Inoue. All rights reserved.
//

import UIKit

protocol PMSideMenuViewControllerDelegate {
    func PMSideMenuViewNumberOfSideMenuListItems() -> NSInteger
    func PMSideMenuListItemAtIndex(index : NSInteger) -> PMSideMenuListItem?
    func PMSideMenuViewControllerTransitionViewControllerWhenSelectedItemAtIndex(viewController : PMSideMenuViewController, index : NSInteger) -> PMSideMenuBaseViewController?
}

private let ANIMATION_DURATION : Double = 0.2

class PMSideMenuViewController: UIViewController, PMSideMenuListViewDelegate, UIGestureRecognizerDelegate {

    // MARK : - Properties
    // Public
    var currentSideMenuIndex : NSInteger = 0
    var delegate : PMSideMenuViewControllerDelegate!

    // Private
    private var contentsNavigationController : UINavigationController = UINavigationController()
    private var sideMenuListView : PMSideMenuListView! = PMSideMenuListView(frame: CGRectZero)
    private var gradientView : PMColorGradientView! = PMColorGradientView(frame: CGRectZero)

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

        self.contentsNavigationController.view.frame = self.view.bounds
        self.contentsNavigationController.view.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        self.contentsNavigationController.view.layer.shadowColor = UIColor.blackColor().CGColor
        self.contentsNavigationController.view.layer.shadowOffset = CGSizeMake(3.0, 3.0)
        self.contentsNavigationController.view.layer.shadowOpacity = 0.3

        self.addChildViewController(self.contentsNavigationController)
        self.view.addSubview(self.contentsNavigationController.view)

        var viewController = self.getViewControllerFromSideMenuIndex(self.currentSideMenuIndex)
        self.setContentViewController(viewController)

        self.sideMenuListView = PMSideMenuListView(frame: self.view.bounds)
        self.sideMenuListView?.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.sideMenuListView?.delegate = self
        self.view.addSubview(self.sideMenuListView!)

        var rightPanGesture : UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "detectRightPanGesture:")
        rightPanGesture.delegate = self
        self.view.addGestureRecognizer(rightPanGesture)

        var leftPanGesture : UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "detectLeftPanGesuture:")
        leftPanGesture.delegate = self
        self.view.addGestureRecognizer(leftPanGesture)

        self.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK : - Class Method
    func transitionToSpecificViewControllerFrimSideMenuType(type : NSInteger){
        var viewController = self.getViewControllerFromSideMenuIndex(type)

        if(self.sideMenuListView?.isVisible == true){
            self.setSideMenuHidden(true, animated: true)
        }

        self.setContentViewController(viewController)

        self.currentSideMenuIndex = type
    }

    func setSideMenuHidden(hidden : Bool, animated : Bool){

        if (hidden) {
            self.sideMenuListView?.setSideMenuHidden(hidden, animated: animated)
            let delayInSeconds = ANIMATION_DURATION * Double(NSEC_PER_SEC);
            let popTime : dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds));
            dispatch_after(popTime, dispatch_get_main_queue(), { () -> Void in
                self.transformContentViewScaleWithSideMenuHidden(hidden, animated: animated)
            })
        }else{
            self.transformContentViewScaleWithSideMenuHidden(hidden, animated: animated)
            let delayInSeconds = ANIMATION_DURATION * Double(NSEC_PER_SEC);
            let popTime : dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds));
            dispatch_after(popTime, dispatch_get_main_queue(), { () -> Void in
                self.sideMenuListView.setSideMenuHidden(hidden, animated: animated)
            })
        }
    }

    func toggleSideMenu(){
        if (self.sideMenuListView.isAnimation == true){
            return
        }

        let isSideMenuVisible : Bool = self.sideMenuListView.isVisible

        self.setSideMenuHidden(isSideMenuVisible, animated: true)
    }

    func reloadData(){

        var sideMenuItemArray : Array<PMSideMenuListItem> = Array()

        for var i = 0; i < self.delegate.PMSideMenuViewNumberOfSideMenuListItems(); i++ {
            var item : PMSideMenuListItem = self.delegate.PMSideMenuListItemAtIndex(i)!
            sideMenuItemArray.append(item)
        }
        self.sideMenuListView.setSideMenuItems(sideMenuItemArray)
    }

    //MARK : - Private Method
    private func getViewControllerFromSideMenuIndex(index : NSInteger) -> PMSideMenuBaseViewController?{
        var viewController = self.delegate.PMSideMenuViewControllerTransitionViewControllerWhenSelectedItemAtIndex(self, index: index)
        return viewController
    }

    private func setContentViewController(viewController : PMSideMenuBaseViewController?){
        if (viewController != nil){
            viewController?.sideMenu = self
            self.contentsNavigationController.viewControllers = [viewController!]
        }
    }

    private func transformContentViewScaleWithSideMenuHidden(hidden :Bool, animated : Bool){

        if (hidden){
            if (animated){
                UIView.animateWithDuration(ANIMATION_DURATION, animations: { () -> Void in

                    self.contentsNavigationController.view.transform = CGAffineTransformIdentity
                    self.contentsNavigationController.view.frame = self.gradientView.frame

                    }, completion: { (finished : Bool) -> Void in

                })
            }else{
                self.contentsNavigationController.view.transform = CGAffineTransformIdentity
                self.contentsNavigationController.view.frame = self.gradientView.frame
            }
        }else{
            if (animated){
                UIView.animateWithDuration(ANIMATION_DURATION, animations: { () -> Void in

                    self.contentsNavigationController.view.transform = CGAffineTransformMakeScale(0.9, 0.9)

                    }, completion: { (finished : Bool) -> Void in

                })
            }else{
                self.contentsNavigationController.view.transform = CGAffineTransformMakeScale(0.9, 0.9)
            }
        }
    }

    private func transformContentViewScaleWithGesture(gesture : UIPanGestureRecognizer){
        if (gesture.state == UIGestureRecognizerState.Changed){
            let ratio : CGFloat = self.sideMenuListView.gestureRatio
            let cRatio : CGFloat = (1 - ratio) * 0.1 + 0.9

            self.contentsNavigationController.view.transform = CGAffineTransformMakeScale(cRatio, cRatio)
        }

        if (gesture.state == UIGestureRecognizerState.Ended){
            self.transformContentViewScaleWithSideMenuHidden(!self.sideMenuListView.isVisible, animated: true)
        }
    }

    // MARK : - SideMenuListViewDelegate

    func PMSideMenuListViewDidSelectedItem(index: NSInteger) {

        if (index == self.currentSideMenuIndex){
            self.setSideMenuHidden(true, animated: true)
            return
        }

        self.transitionToSpecificViewControllerFrimSideMenuType(index)
    }

    func PMSideMenuListViewDidCancel() {
        self.setSideMenuHidden(true, animated: true)
    }

    // MARK : - Gesture Action

    func detectRightPanGesture(gesture : UIPanGestureRecognizer){
        self.sideMenuListView.setSideMenuWithGesture(gesture)
        self.transformContentViewScaleWithGesture(gesture)
    }

    func detectLeftPanGesuture(gesture : UIPanGestureRecognizer){
        self.sideMenuListView.setSideMenuWithGesture(gesture)
        self.transformContentViewScaleWithGesture(gesture)
    }

    // MARK : - UIPanGestureRecognizerDelegate

    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {

        if (self.sideMenuListView.isVisible == false){
            let touchPoint : CGPoint = touch.locationInView(self.view)
            if (touchPoint.x < 20){
                return true
            }
        }

        if (self.sideMenuListView.isVisible == true){
            let touchPoint : CGPoint = touch.locationInView(self.view)
            if (CGRectContainsPoint(self.sideMenuListView.contentView.frame, touchPoint)){
                return true
            }
        }

        return false
    }

}
