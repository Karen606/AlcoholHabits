//
//  Font.swift
//  AlcoholHabits
//
//  Created by Karen Khachatryan on 15.11.24.
//

import UIKit

extension UIFont {
    
    static func mediumSFPro(size: CFloat) -> UIFont? {
        return UIFont(name: "SFProText-Medium", size: CGFloat(size))
    }
    
    static func semiBold(size: CFloat) -> UIFont? {
        return UIFont(name: "SFProText-Semibold", size: CGFloat(size))
    }
    
    static func mediumZen(size: CFloat) -> UIFont? {
        return UIFont(name: "ZenKakuGothicNew-Medium", size: CGFloat(size))
    }
    
    static func regularZen(size: CFloat) -> UIFont? {
        return UIFont(name: "ZenKakuGothicNew-Regular", size: CGFloat(size))
    }
}
