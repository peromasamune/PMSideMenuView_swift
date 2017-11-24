//
//  PMSideMenuViewController.swift
//  PMSideMenuView_Demo
//
//  Created by Taku Inoue on 2015/02/13.
//  Copyright (c) 2015年 Taku Inoue. All rights reserved.
//

import UIKit

protocol PMSideMenuViewControllerDelegate : class {
    func PMSideMenuViewNumberOfSideMenuListItems() -> NSInteger
    func PMSideMenuListItemAtIndex(index : NSInteger) -> PMSideMenuListItem?
    func PMSideMenuViewControllerTransitionViewControllerWhenSelectedItemAtIndex(viewController : PMSideMenuViewController, index : NSInteger) -> PMSideMenuBaseViewController?
}

private let ANIMATION_DURATION : Double = 0.2

class PMSideMenuViewController: UIViewController, PMSideMenuListViewDelegate, UIGestureRecognizerDelegate {

    //MARK: - Properties
    //Public
    var currentSideMenuIndex : NSInteger = 0 
    weak var delegate : PMSideMenuViewControllerDelegate?
    var sideMenuEnabled : Bool = true

    //Private
    //TODO: fixit
    private var contentsNavigationController : UINavigationController = UINavigationController()//UINavigationController(navigationBarClass: FLNavigationBar.self, toolbarClass: nil)
    private var sideMenuListView : PMSideMenuListView = PMSideMenuListView(frame: .zero)
    private var gradientView : PMColorGradientView = PMColorGradientView(frame: .zero)

    //MARK: - Initializer
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createView()
    }

    func createView(){
        self.gradientView = PMColorGradientView(frame: self.view.frame)
        self.gradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        //TODO: fixit
        //let backgoundImageView = UIImageView(frame: self.view.bounds)
        //backgoundImageView.image = UIImage(named: FLDayAndNightUtility.converImageName("backImage"))
        self.view.addSubview(self.gradientView)

        //TODO: fixit
        //var bulrView = FLBlurView(frame: self.view.frame)
        //bulrView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        //self.view.addSubview(bulrView)

        self.contentsNavigationController.view.frame = self.view.bounds
        self.contentsNavigationController.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.contentsNavigationController.view.layer.shadowColor = UIColor.black.cgColor
        self.contentsNavigationController.view.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        self.contentsNavigationController.view.layer.shadowOpacity = 0.3

        self.addChildViewController(self.contentsNavigationController)
        self.view.addSubview(self.contentsNavigationController.view)

        self.sideMenuListView = PMSideMenuListView(frame: self.view.bounds)
        self.sideMenuListView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.sideMenuListView.delegate = self
        self.view.addSubview(self.sideMenuListView)

        let rightPanGesture = UIPanGestureRecognizer(target: self, action: #selector(detectRightPanGesture(gesture:)))
        rightPanGesture.delegate = self
        self.view.addGestureRecognizer(rightPanGesture)

        let leftPanGesture = UIPanGestureRecognizer(target: self, action: #selector(detectLeftPanGesuture(gesture:)))
        leftPanGesture.delegate = self
        self.view.addGestureRecognizer(leftPanGesture)

        self.updateAppearance()
        self.transitionToSpecificViewControllerFrimSideMenuType(type: self.currentSideMenuIndex)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - Class Method
    func updateAppearance() {
        self.reloadData()
        //self.sideMenuListView.contentView.updateAppearance()
    }
    
    func transitionToSpecificViewControllerFrimSideMenuType(type : NSInteger){
        let viewController = self.getViewControllerFromSideMenuIndex(index: type)

        if(self.sideMenuListView.isVisible == true){
            self.setSideMenuHidden(hidden: true, animated: true)
        }

        self.setContentViewController(viewController: viewController)

        self.currentSideMenuIndex = type
        self.sideMenuListView.currentSelectedIndex = type
    }

    func setSideMenuHidden(hidden : Bool, animated : Bool){
        if self.sideMenuEnabled == false {
            return
        }

        if (hidden) {
            self.sideMenuListView.setSideMenuHidden(hidden: hidden, animated: animated)
            self.transformContentViewScaleWithSideMenuHidden(hidden: hidden, animated: animated)
        }else{
            self.reloadData()
            self.transformContentViewScaleWithSideMenuHidden(hidden: hidden, animated: animated)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                self.sideMenuListView.setSideMenuHidden(hidden: hidden, animated: animated)
            })
        }
    }

    func toggleSideMenu(){
        if self.sideMenuEnabled == false {
            return
        }
        
        if self.sideMenuListView.isAnimation == true{
            return
        }

        let isSideMenuVisible : Bool = self.sideMenuListView.isVisible

        self.setSideMenuHidden(hidden: isSideMenuVisible, animated: true)
    }

    func reloadData(){
        var sideMenuItemArray : [PMSideMenuListItem] = []

        guard let numOfItems = self.delegate?.PMSideMenuViewNumberOfSideMenuListItems() else {
            fatalError()
        }
        
        for i in 0..<numOfItems {
            if let item = self.delegate?.PMSideMenuListItemAtIndex(index: i) {
                sideMenuItemArray.append(item)
            }
        }
        self.sideMenuListView.setSideMenuItems(items: sideMenuItemArray)
    }
    
    func isSideMenuAnimation() -> Bool {
        return self.sideMenuListView.isAnimation
    }

    //MARK: - Private Method
    private func getViewControllerFromSideMenuIndex(index : NSInteger) -> PMSideMenuBaseViewController?{
        return self.delegate?.PMSideMenuViewControllerTransitionViewControllerWhenSelectedItemAtIndex(viewController: self, index: index)
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
                UIView.animate(withDuration: ANIMATION_DURATION, animations: {
                    self.contentsNavigationController.view.transform = .identity
                    self.contentsNavigationController.view.frame = self.gradientView.frame
                })
            }else{
                self.contentsNavigationController.view.transform = .identity
                self.contentsNavigationController.view.frame = self.gradientView.frame
            }
        }else{
            if (animated){
                UIView.animate(withDuration: ANIMATION_DURATION, animations: {
                    self.contentsNavigationController.view.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                    
                    var frame = self.contentsNavigationController.view.frame
                    frame.origin.x = 220
                    self.contentsNavigationController.view.frame = frame
                })
            }else{
                self.contentsNavigationController.view.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                var frame = self.contentsNavigationController.view.frame
                frame.origin.x = 220
                self.contentsNavigationController.view.frame = frame
            }
        }
    }

    private func transformContentViewScaleWithGesture(gesture : UIPanGestureRecognizer){
        
        if (gesture.state == .changed){
            let ratio : CGFloat = self.sideMenuListView.gestureRatio
            let cRatio : CGFloat = (1 - ratio) * 0.3 + 0.7

            self.contentsNavigationController.view.transform = CGAffineTransform(scaleX: cRatio, y: cRatio)
            
            var frame = self.contentsNavigationController.view.frame
            frame.origin.x = 220 * ratio
            self.contentsNavigationController.view.frame = frame
        }

        if (gesture.state == .ended){
            self.transformContentViewScaleWithSideMenuHidden(hidden: !self.sideMenuListView.isVisible, animated: true)
        }
    }

    //MARK: - SideMenuListViewDelegate
    func PMSideMenuListViewDidSelectedItem(index: NSInteger) {

        if (index == self.currentSideMenuIndex){
            self.setSideMenuHidden(hidden: true, animated: true)
            return
        }

        self.transitionToSpecificViewControllerFrimSideMenuType(type: index)
    }

    func PMSideMenuListViewDidCancel() {
        self.setSideMenuHidden(hidden: true, animated: true)
    }

    //MARK: - Gesture Action
    @objc func detectRightPanGesture(gesture : UIPanGestureRecognizer){
        self.sideMenuListView.setSideMenuWithGesture(gesture: gesture)
        self.transformContentViewScaleWithGesture(gesture: gesture)
    }

    @objc func detectLeftPanGesuture(gesture : UIPanGestureRecognizer){
        self.sideMenuListView.setSideMenuWithGesture(gesture: gesture)
        self.transformContentViewScaleWithGesture(gesture: gesture)
    }

    //MARK: - UIPanGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if self.sideMenuEnabled == false {
            return false
        }
        
        if (self.sideMenuListView.isVisible == false){
            let touchPoint : CGPoint = touch.location(in: self.view)
            if (touchPoint.x < 20){
                return true
            }
        }
        
        if (self.sideMenuListView.isVisible == true){
            return true
        }
        
        return false
    }
}
