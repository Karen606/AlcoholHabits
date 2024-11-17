//
//  CalendarViewModel.swift
//  AlcoholHabits
//
//  Created by Karen Khachatryan on 17.11.24.
//

import Foundation

class CalendarViewModel {
    static let shared = CalendarViewModel()
    @Published var drinks: [DrinkModel] = []
    private init() {}
    
    func fetchData() {
        CoreDataManager.shared.fetchDrinks { [weak self] drinks, _ in
            guard let self = self else { return }
            self.drinks = drinks
        }
    }
}
