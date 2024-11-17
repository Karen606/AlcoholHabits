//
//  CoreDataManager.swift
//  AlcoholHabits
//
//  Created by Karen Khachatryan on 17.11.24.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AlcoholHabits")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveDrink(drinkModel: DrinkModel, completion: @escaping (Error?) -> Void) {
        let id = drinkModel.id ?? UUID()
        let backgroundContext = persistentContainer.newBackgroundContext()
        backgroundContext.perform {
            let fetchRequest: NSFetchRequest<Drink> = Drink.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            
            do {
                let results = try backgroundContext.fetch(fetchRequest)
                let drink: Drink
                
                if let existingDrink = results.first {
                    drink = existingDrink
                } else {
                    drink = Drink(context: backgroundContext)
                    drink.id = id
                }
                drink.date = drinkModel.date
                drink.price = drinkModel.price ?? 0
                drink.quantity = Int64(drinkModel.quantity)
                drink.strength = drinkModel.strength ?? 0
                drink.type = Int64(drinkModel.type ?? 0)
                drink.volume = drinkModel.volume ?? 0

                try backgroundContext.save()
                DispatchQueue.main.async {
                    completion(nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(error)
                }
            }
        }
    }
    
    func fetchDrinks(completion: @escaping ([DrinkModel], Error?) -> Void) {
        let backgroundContext = persistentContainer.newBackgroundContext()
        backgroundContext.perform {
            let fetchRequest: NSFetchRequest<Drink> = Drink.fetchRequest()
            do {
                let results = try backgroundContext.fetch(fetchRequest)
                var drinksModel: [DrinkModel] = []
                for result in results {
                    let drinkModel = DrinkModel(id: result.id, date: result.date, type: Int(result.type), volume: result.volume, strength: result.strength, quantity: Int(result.quantity), price: result.price)
                    drinksModel.append(drinkModel)
                }
                DispatchQueue.main.async {
                    completion(drinksModel, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion([], error)
                }
            }
        }
    }
}
