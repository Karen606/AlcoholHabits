//
//  String.swift
//  AlcoholHabits
//
//  Created by Karen Khachatryan on 15.11.24.
//

import Foundation

extension String? {
    func checkValidation() -> Bool {
        guard let self = self else { return false }
        return !self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}

extension String {
    func checkValidation() -> Bool {
        return !self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
