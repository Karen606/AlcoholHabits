//
//  SectionButton.swift
//  AlcoholHabits
//
//  Created by Karen Khachatryan on 15.11.24.
//

import UIKit

class SectionButton: UIButton {
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.addBottomBorder(color: #colorLiteral(red: 0.2765623629, green: 0.6707799435, blue: 1, alpha: 1), thickness: 3)
                self.titleLabel?.font = .mediumZen(size: 22)
            } else {
                self.removeBottomBorder()
                self.titleLabel?.font = .regularZen(size: 20)
            }
        }
    }
    
    override init(frame: CGRect) {
         super.init(frame: frame)
        self.titleLabel?.font = .regularZen(size: 20)
     }
     
     required init?(coder: NSCoder) {
         super.init(coder: coder)
         self.titleLabel?.font = .regularZen(size: 20)
     }
}
