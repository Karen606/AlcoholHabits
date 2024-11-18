//
//  StatisticsViewModel.swift
//  AlcoholHabits
//
//  Created by Karen Khachatryan on 18.11.24.
//

import Foundation

class StatisticsViewModel {
    static let shared = StatisticsViewModel()
    private var data: [DrinkModel] = []
    @Published var drinks: [DrinkModel] = []
    var selectedPeriod: Int = 0
    private let calendar = Calendar.current

    private init() {}
    
    func fetchData() {
        CoreDataManager.shared.fetchDrinks { [weak self] drinks, _ in
            guard let self = self else { return }
            self.data = drinks
            filter(by: selectedPeriod)
        }
    }
    
    func filter(by index: Int) {
        selectedPeriod = index
        switch index {
        case 0:
            drinks = data.filter { drink in
                guard let drinkDate = drink.date else { return false }
                return calendar.isDate(drinkDate, equalTo: Date(), toGranularity: .weekOfYear)
            }
        case 1:
            drinks = data.filter { drink in
                guard let drinkDate = drink.date else { return false }
                return calendar.isDate(drinkDate, equalTo: Date(), toGranularity: .month)
            }
        case 2:
            drinks = data.filter { drink in
                guard let drinkDate = drink.date else { return false }
                return calendar.isDate(drinkDate, equalTo: Date(), toGranularity: .year)
            }
            
        default:
            drinks = data
        }
    }
    
    func maxConsecutiveDays() -> Int {
            // Extract and normalize valid dates
            let calendar = Calendar.current
        let normalizedDates = drinks.compactMap { $0.date }
                .map { calendar.startOfDay(for: $0) } // Normalize to start of the day
                .sorted() // Sort dates
            
            guard !normalizedDates.isEmpty else { return 0 }
            
            var maxStreak = 1
            var currentStreak = 1
            
            // Traverse sorted dates to find consecutive streaks
            for i in 1..<normalizedDates.count {
                let previousDate = normalizedDates[i - 1]
                let currentDate = normalizedDates[i]
                
                // Check if the current date is consecutive to the previous date
                if let dayDifference = calendar.dateComponents([.day], from: previousDate, to: currentDate).day,
                   dayDifference == 1 {
                    currentStreak += 1
                    maxStreak = max(maxStreak, currentStreak)
                } else {
                    currentStreak = 1 // Reset streak if not consecutive
                }
            }
            
            return maxStreak
        }
    
    func calculateTotalPrice() -> Double {
        return drinks.reduce(0) { total, drink in
            guard let price = drink.price else { return total }
            return total + (price * Double(drink.quantity))
        }
    }
    
    func numberOfDrinkingDays() -> Int {
        let calendar = Calendar.current
        let uniqueDays: Set<Date> = Set(drinks.compactMap { drink in
            guard let date = drink.date else { return nil }
            return calendar.startOfDay(for: date) // Normalize to the start of the day
        })
        return uniqueDays.count
    }
}
