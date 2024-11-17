//
//  DrinkFormViewModel.swift
//  AlcoholHabits
//
//  Created by Karen Khachatryan on 17.11.24.
//

import Foundation

class DrinkFormViewModel {
    static let shared = DrinkFormViewModel()
    @Published var drinkModel = DrinkModel(id: UUID(), date: Date())
    private init() {}
    
    func save(completion: @escaping (Error?) -> Void) {
        CoreDataManager.shared.saveDrink(drinkModel: drinkModel, completion: completion)
    }
    
    func clear() {
        drinkModel = DrinkModel(id: UUID())
    }
}
