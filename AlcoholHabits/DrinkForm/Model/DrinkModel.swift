//
//  DrinkFormModel.swift
//  AlcoholHabits
//
//  Created by Karen Khachatryan on 17.11.24.
//

import Foundation

struct DrinkModel {
    var id: UUID?
    var date: Date?
    var type: Int?
    var volume: Double?
    var strength: Double?
    var quantity: Int = 1
    var price: Double?
}
