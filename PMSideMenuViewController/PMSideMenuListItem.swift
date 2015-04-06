//
//  PMSideMenuListItem.swift
//  PMSideMenuView_Demo_swift
//
//  Created by Taku Inoue on 2015/04/06.
//  Copyright (c) 2015年 Taku Inoue. All rights reserved.
//

import UIKit

enum PMSideMenuListItemType{
    case Default
    case CircleImage
}

class PMSideMenuListItem: NSObject {

    // MARK : - Property
    // Public
    var title : NSString?
    var imageUrl : NSString?
    var type : PMSideMenuListItemType! = PMSideMenuListItemType.Default
    var cellHeight : CGFloat! = 0

    // MARK : - Constructor
    class func itemWith(title : NSString, image : NSString) -> PMSideMenuListItem{
        var item : PMSideMenuListItem = PMSideMenuListItem(title: title, image: image);
        return item
    }

    // MARK : - Initializer
    init(title : NSString, image : NSString){
        super.init()

        self.title = title
        self.imageUrl = image
    }
}
