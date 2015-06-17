//
//  PMColorModel.swift
//  PMSideMenuView_Demo
//
//  Created by Taku Inoue on 2015/02/13.
//  Copyright (c) 2015年 Taku Inoue. All rights reserved.
//

import UIKit

class PMColorModel: NSObject {

    class func colorList() -> NSArray {

        let colorArray : NSArray = [
            UIColor(red: 0.749, green: 0.220, blue: 0.188, alpha: 1.000),
            UIColor(red: 0.761, green: 0.416, blue: 0.157, alpha: 1.000),
            UIColor(red: 0.761, green: 0.627, blue: 0.090, alpha: 1.000),
            UIColor(red: 0.553, green: 0.788, blue: 0.075, alpha: 1.000),
            UIColor(red: 0.165, green: 0.780, blue: 0.510, alpha: 1.000),
            UIColor(red: 0.212, green: 0.686, blue: 0.776, alpha: 1.000),
            UIColor(red: 0.200, green: 0.442, blue: 0.788, alpha: 1.000),
            UIColor(red: 0.447, green: 0.173, blue: 0.800, alpha: 1.000),
            UIColor(red: 0.682, green: 0.169, blue: 0.800, alpha: 1.000),
            UIColor(red: 0.951, green: 0.212, blue: 0.474, alpha: 1.000)
        ]

        return colorArray
    }

    class func getRandomColor() -> UIColor{

        let colorArray : NSArray = PMColorModel.colorList()

        let random : Int = Int(arc4random()) % colorArray.count

        if(colorArray.count > random){
            return colorArray.objectAtIndex(random) as! UIColor
        }

        return UIColor.whiteColor()
    }

    class func gradientBaseDarkColor() -> UIColor{
        return UIColor(red: 0.275, green: 0.275, blue: 0.345, alpha: 1.000)
    }

    class func getNearRandomColorsForGradient() -> NSArray{

        let colorArray : NSArray = PMColorModel.colorList()

        let random1 : Int = Int(arc4random()) % colorArray.count
        var random2 : Int = random1 + 1
        if (random2 >= colorArray.count){
            random2 = 0
        }

        let color1 : UIColor = colorArray.objectAtIndex(random1) as! UIColor
        let color2 : UIColor = colorArray.objectAtIndex(random2) as! UIColor

        return [color1.CGColor, color2.CGColor]
    }
}
