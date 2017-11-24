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

    //MARK: - Property
    //Public
    var title : String?
    var imageUrl : String?
    var type : PMSideMenuListItemType! = PMSideMenuListItemType.Default
    var cellHeight : CGFloat! = 0

    //MARK: - Constructor
    class func itemWith(title : String, image : String) -> PMSideMenuListItem{
        return PMSideMenuListItem(title: title, image: image)
    }

    //MARK: - Initializer
    init(title : String, image : String){
        super.init()

        self.title = title
        self.imageUrl = image
    }
}
