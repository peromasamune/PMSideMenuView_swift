//
//  PMSideMenuListView.swift
//  PMSideMenuView_Demo
//
//  Created by Taku Inoue on 2015/02/13.
//  Copyright (c) 2015年 Taku Inoue. All rights reserved.
//

import UIKit

protocol PMSideMenuListViewDelegate{
    func PMSideMenuListViewDidSelectedItem(index : NSInteger)
    func PMSideMenuListViewDidCancel()
}

private let ITEM_HEIGHT : CGFloat = 50
private let ITEM_WIDTH : CGFloat = 200
private let ITEM_OFFSET : CGFloat = 7
private let ANIMATION_DURATION : NSTimeInterval = 0.2

class PMSideMenuListView: UIView, UITableViewDelegate, UITableViewDataSource{

    // MARK : - Const
    var previousPoint : CGPoint = CGPointZero
    var lastMotionDiff : CGPoint = CGPointZero

    // MARK : - Callback

    // MARK : - Property
    // Public
    var contentView : UIView!
    var isVisible : Bool! = false
    var isAnimation : Bool! = false
    var currentSelectedIndex : NSInteger! = 0 {
        didSet {
            self.tableView?.reloadData()
        }
    }
    var delegate : PMSideMenuListViewDelegate! = nil
    private(set) var gestureRatio : CGFloat = 0

    // Private
    private var tableView : UITableView?
    private var itemArray : NSMutableArray! = NSMutableArray()

    // MARK : - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor(white: 0.000, alpha: 0.0)
        self.alpha = 0.0

        isVisible = false;
        isAnimation = false;
        currentSelectedIndex = 0

        contentView = UIView()
        contentView.backgroundColor = UIColor.clearColor()
//        contentView.layer.shadowColor = UIColor.blackColor().CGColor
//        contentView.layer.shadowOffset = CGSizeMake(3.0, 3.0)
//        contentView.layer.shadowOpacity = 0.3
        self.addSubview(contentView)
        
        tableView = UITableView()
        tableView?.backgroundColor = UIColor.clearColor()
        tableView?.delegate = self;
        tableView?.dataSource = self;
        tableView?.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView?.showsVerticalScrollIndicator = false;
        tableView?.tableFooterView = UIView()
        self.contentView.addSubview(tableView!)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    // MARK : - Class Method
    func setSideMenuItems(items : Array<PMSideMenuListItem>){
        itemArray = NSMutableArray()

        for item : PMSideMenuListItem in items {
            itemArray.addObject(item)
        }

        self.reloadFrame()
    }

    func setSideMenuHidden(hidden : Bool, animated : Bool){

        if (isAnimation == true) {
            return
        }

        if (animated == true) {
            isAnimation = true
        }

        self.tableView?.scrollsToTop = !hidden

        let duration : NSTimeInterval = (animated) ? ANIMATION_DURATION : 0.0

        if (hidden) {
            UIView.animateWithDuration(duration, animations: { () -> Void in

                var frame : CGRect = self.contentView.frame
                frame.origin.x = -frame.size.width
                self.contentView.frame = frame
                self.backgroundColor = UIColor(white: 0.000, alpha: 0.0)
                
                }, completion: { (finished : Bool) -> Void in

                    self.alpha = 0.0
                    self.isAnimation = false
            })
        }else{
            self.alpha = 1.0
            UIView.animateWithDuration(duration, animations: { () -> Void in

                var frame : CGRect = self.contentView.frame
                frame.origin.x = 0
                self.contentView.frame = frame
                self.backgroundColor = UIColor(white: 0.000, alpha: 0.1)

                }, completion: { (finished : Bool) -> Void in
                    self.isAnimation = false
            })
        }

        self.gestureRatio = (hidden) ? 0.0 : 1.0
        self.isVisible = !hidden
    }

    func setSideMenuWithGesture(gesture : UIPanGestureRecognizer){

        if gesture.state == UIGestureRecognizerState.Began {
            previousPoint = gesture.locationInView(self)
            self.alpha = 1.0
        }

        if gesture.state == UIGestureRecognizerState.Changed {
            var motionPoint : CGPoint = gesture.locationInView(self)

            var motionDiff : CGPoint = motionPoint
            motionDiff.x = motionPoint.x - previousPoint.x
            motionDiff.y = motionPoint.y - previousPoint.y

            var contentViewRect : CGRect = self.contentView.frame

            var resultPointX = contentViewRect.origin.x + motionDiff.x
            if (resultPointX > 0) {resultPointX = 0}
            if (resultPointX <= -contentViewRect.size.width) {resultPointX = -contentViewRect.size.width}

            contentViewRect.origin.x = resultPointX
            self.contentView.frame = contentViewRect

            self.gestureRatio = ((contentViewRect.origin.x + self.contentView.frame.size.width) / self.contentView.frame.size.width)
            self.backgroundColor = UIColor(white: 0.000, alpha: self.gestureRatio * 0.1)
            
            previousPoint = motionPoint
            lastMotionDiff = motionDiff
        }

        if gesture.state == UIGestureRecognizerState.Ended {

            let isAnimated : Bool = !(self.contentView.frame.origin.x == -self.contentView.frame.size.width || self.contentView.frame.origin.x == 0)
            var isHidden : Bool = (self.contentView.frame.origin.x < -self.contentView.frame.size.width / 2)

            if (lastMotionDiff.x > 10){
                isHidden = false
            }
            if (lastMotionDiff.x < -10){
                isHidden = true
            }

            self.setSideMenuHidden(isHidden, animated: isAnimated)
        }
    }
    
    // MARK : - Private Method
    private func reloadFrame(){
        self.contentView.frame = CGRectMake((self.alpha > 0.0) ? 0 : -ITEM_WIDTH, 0, ITEM_WIDTH, self.frame.size.height)
        self.tableView?.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)
        
        self.tableView?.reloadData()
        
        if let tableView = self.tableView {
            let contentSize = tableView.contentSize
            let boundSize = tableView.bounds.size
            var yOffset : Float = 0
            if contentSize.height < boundSize.height {
                yOffset = floorf((Float(boundSize.height) - Float(contentSize.height)) / 2)
            }
            tableView.contentInset = UIEdgeInsetsMake(CGFloat(yOffset) - 40, 0, 0, 0)
        }
    }

    // MARK : - Touch Event
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if (self.isAnimation == true){
            return;
        }
        self.delegate.PMSideMenuListViewDidCancel()
    }

    // MARK : - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var item : PMSideMenuListItem = itemArray.objectAtIndex(indexPath.row) as! PMSideMenuListItem
        if item.cellHeight > 0 {
            return item.cellHeight
        }
        return 44
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier = "Cell"
        let UserCellIdentifier = "UserCell"

        var item : PMSideMenuListItem = itemArray.objectAtIndex(indexPath.row) as! PMSideMenuListItem

        let mode = FLDayAndNightUtility.currentMode()
        
        if item.type == PMSideMenuListItemType.Default {
            var cell : PMSideMenuBasicCellTableViewCell? = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as? PMSideMenuBasicCellTableViewCell
            if cell == nil {
                cell = PMSideMenuBasicCellTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: CellIdentifier)

            }

            cell?.titleLabel.textColor = UIColor.whiteColor()
            cell?.titleLabel.text = item.title
            cell?.highlightedColor = UIColor(red: 0.937, green: 0.596, blue: 0.196, alpha: 1.000)
            if let imageUrl = item.imageUrl {
                if imageUrl.length > 0 {
                    cell?.defaultImage = UIImage(named: imageUrl)
                }
            }
            cell?.isCellSelected = (self.currentSelectedIndex == indexPath.row)

            return cell!
        }

        if item.type == PMSideMenuListItemType.CircleImage {
            let userCell : PMSideMenuUserCell = PMSideMenuUserCell(style: UITableViewCellStyle.Default, reuseIdentifier: UserCellIdentifier)

            userCell.userNameLabel.textColor = UIColor.whiteColor()
            userCell.userNameLabel.text = item.title
            if let imageUrl = item.imageUrl {
                userCell.iconImageView.setImage(imageUrl)
            }
            userCell.selectionStyle = UITableViewCellSelectionStyle.None

            return userCell
        }

        return UITableViewCell()
    }

    // MARK : - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        if let item = itemArray.objectAtIndex(indexPath.row) as? PMSideMenuListItem {
            if item.type == PMSideMenuListItemType.CircleImage {
                return
            }
        }
        
        self.delegate.PMSideMenuListViewDidSelectedItem(indexPath.row)
    }

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }
}
