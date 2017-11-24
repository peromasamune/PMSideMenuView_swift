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

private let ITEM_WIDTH : CGFloat = 200
private let ITEM_OFFSET : CGFloat = 7
private let ANIMATION_DURATION : TimeInterval = 0.2

class PMSideMenuListView: UIView, UITableViewDelegate, UITableViewDataSource{

    //MARK: - Const
    var previousPoint : CGPoint = .zero
    var lastMotionDiff : CGPoint = .zero

    //MARK: - Callback

    //MARK: - Property
    //Public
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

    //Private
    private var tableView : UITableView!
    private var itemArray : [PMSideMenuListItem] = []

    //MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .clear
        self.alpha = 0.0

        isVisible = false;
        isAnimation = false;
        currentSelectedIndex = 0

        contentView = UIView()
        contentView.backgroundColor = .clear
        self.addSubview(contentView)
        
        tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.showsVerticalScrollIndicator = false;
        tableView.tableFooterView = UIView()
        self.contentView.addSubview(tableView)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    // MARK: - Class Method
    func setSideMenuItems(items : [PMSideMenuListItem]){
        itemArray = []

        for item : PMSideMenuListItem in items {
            itemArray.append(item)
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

        self.tableView.scrollsToTop = !hidden

        let duration : TimeInterval = (animated) ? ANIMATION_DURATION : 0.0

        if (hidden) {
            UIView.animate(withDuration: duration, animations: {
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
            UIView.animate(withDuration: duration, animations: {
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

        if gesture.state == UIGestureRecognizerState.began {
            previousPoint = gesture.location(in: self)
            self.alpha = 1.0
        }

        if gesture.state == UIGestureRecognizerState.changed {
            let motionPoint : CGPoint = gesture.location(in: self)

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

        if gesture.state == UIGestureRecognizerState.ended {

            let isAnimated : Bool = !(self.contentView.frame.origin.x == -self.contentView.frame.size.width || self.contentView.frame.origin.x == 0)
            var isHidden : Bool = (self.contentView.frame.origin.x < -self.contentView.frame.size.width / 2)

            if (lastMotionDiff.x > 10){
                isHidden = false
            }
            if (lastMotionDiff.x < -10){
                isHidden = true
            }

            self.setSideMenuHidden(hidden: isHidden, animated: isAnimated)
        }
    }
    
    //MARK : - Private Method
    private func reloadFrame(){
        self.contentView.frame = CGRect(x: (self.alpha > 0.0) ? 0 : -ITEM_WIDTH, y: 0, width: ITEM_WIDTH, height: self.frame.size.height)
        self.tableView.frame = CGRect(x: 0, y: 0, width: self.contentView.frame.size.width, height: self.contentView.frame.size.height)
        
        let contentSize = self.tableView.contentSize
        let boundSize = self.tableView.bounds.size
        var yOffset : Float = 0
        if contentSize.height < boundSize.height {
            yOffset = floorf((Float(boundSize.height) - Float(contentSize.height)) / 2)
        }
        self.tableView.contentInset = UIEdgeInsetsMake(CGFloat(yOffset) - 20, 0, 0, 0)
        
        self.tableView.reloadData()
    }

    //MARK: - Touch Event
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.isAnimation == true){
            return;
        }
        self.delegate.PMSideMenuListViewDidCancel()
    }

    //MARK: - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = itemArray[indexPath.row]
        if item.cellHeight > 0 {
            return item.cellHeight
        }
        return 44
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellIdentifier = "Cell"
        let UserCellIdentifier = "UserCell"

        let item = itemArray[indexPath.row]
        
        if item.type == PMSideMenuListItemType.Default {
            var cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier) as? PMSideMenuBasicCellTableViewCell
            if cell == nil {
                cell = PMSideMenuBasicCellTableViewCell(style: .default, reuseIdentifier: CellIdentifier)
            }

            cell?.titleLabel.textColor = .white
            cell?.titleLabel.text = item.title
            cell?.highlightedColor = UIColor(red: 0.937, green: 0.596, blue: 0.196, alpha: 1.000)
            if let imageUrl = item.imageUrl {
                if imageUrl.count > 0 {
                    cell?.defaultImage = UIImage(named: imageUrl)
                }
            }
            cell?.isCellSelected = (self.currentSelectedIndex == indexPath.row)

            return cell!
        }

        if item.type == PMSideMenuListItemType.CircleImage {
            let userCell : PMSideMenuUserCell = PMSideMenuUserCell(style: .default, reuseIdentifier: UserCellIdentifier)

            userCell.userNameLabel.textColor = UIColor.white
            userCell.userNameLabel.text = item.title
            //TODO: fixit
            if let imageUrl = item.imageUrl {
//                userCell.iconImageView.setImage(url: imageUrl)
            }
            userCell.selectionStyle = .none

            return userCell
        }

        return UITableViewCell()
    }

    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = itemArray[indexPath.row]
        if item.type == PMSideMenuListItemType.CircleImage {
            return
        }
        
        self.delegate.PMSideMenuListViewDidSelectedItem(index: indexPath.row)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
}
