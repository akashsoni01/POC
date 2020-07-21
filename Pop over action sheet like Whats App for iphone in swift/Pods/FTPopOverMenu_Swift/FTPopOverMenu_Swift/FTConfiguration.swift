//
//  FTConfiguration.swift
//  FTPopOverMenu_Swift
//
//  Created by Abdullah Selek on 28/07/2017.
//  Copyright © 2016 LiuFengting (https://github.com/liufengting) . All rights reserved.
//

import UIKit

open class FTConfiguration {

    open var menuRowHeight = FT.DefaultMenuRowHeight
    open var menuWidth = FT.DefaultMenuWidth
    open var borderColor = FT.DefaultTintColor
    open var borderWidth = FT.DefaultBorderWidth
    open var backgoundTintColor = FT.DefaultTintColor
    open var cornerRadius = FT.DefaultCornerRadius
    open var menuSeparatorColor = UIColor.lightGray
    open var menuSeparatorInset = UIEdgeInsets.init(top: 0, left: FT.DefaultCellMargin, bottom: 0, right: FT.DefaultCellMargin)
    open var cellSelectionStyle = UITableViewCell.SelectionStyle.none
    open var globalShadow = false
    open var shadowAlpha: CGFloat = 0.6
    open var localShadow = false

    public static var shared : FTConfiguration {
        struct StaticConfig {
            static let instance : FTConfiguration = FTConfiguration()
        }
        return StaticConfig.instance
    }

}

