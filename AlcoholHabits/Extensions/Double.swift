//
//  Double.swift
//  AlcoholHabits
//
//  Created by Karen Khachatryan on 18.11.24.
//

import Foundation

extension Double? {
    func formattedToString() -> String {
        guard let self = self else { return "" }
        if Double(Int(self)) == self {
            return "\(Int(self))"
        } else {
            return "\(self)"
        }
    }
}

extension Double {
    func formattedToString() -> String {
        if Double(Int(self)) == self {
            return "\(Int(self))"
        } else {
            return "\(self)"
        }
    }
}
