//
//  ShadowView.swift
//  AlcoholHabits
//
//  Created by Karen Khachatryan on 15.11.24.
//


import UIKit

class ShadowView: UIView {
    
    override init(frame: CGRect) {
         super.init(frame: frame)
        addShadow()
     }
     
     required init?(coder: NSCoder) {
         super.init(coder: coder)
         addShadow()
     }
}
