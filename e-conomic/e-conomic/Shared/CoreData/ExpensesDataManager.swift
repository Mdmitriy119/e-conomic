//
//  ExpensesDataManager.swift
//  e-conomic
//
//  Created by Dumitru Manea on 23.07.2024.
//

import CoreData

protocol ExpensesDataManagerServicing {
    func addExpense(title: String,
                    details: String,
                    total: Double,
                    currency: String,
                    date: Date,
                    photo: NSData?)
    func delete(expense: Expense)
}

final class ExpensesDataManager: ExpensesDataManagerServicing {
    // MARK: - Private properties
    private let containerName = "ExpensesDataModel"
    private let persistentContainer: NSPersistentContainer
    private var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // MARK: - Public properties
    static let shared = ExpensesDataManager()
    let fetchResultsController: NSFetchedResultsController<Expense>
    
    // MARK: - Initializer
    private init() {
        persistentContainer = NSPersistentContainer(name: containerName)
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error {
                fatalError(error.localizedDescription)
            }
        }
        let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest() as! NSFetchRequest<Expense>
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
    }
}

// MARK: - Private methods
private extension ExpensesDataManager {
    func saveIfNeeded() {
        if context.hasChanges {
           try? context.save()
        }
    }
}

// MARK: - Public methods
extension ExpensesDataManager {
    func addExpense(title: String,
                    details: String,
                    total: Double,
                    currency: String,
                    date: Date,
                    photo: NSData?) {
        let _ = Expense(
            context: context,
            title: title,
            details: details,
            total: total,
            currency: currency,
            date: date,
            photo: photo)
        saveIfNeeded()
    }
    
    func delete(expense: Expense) {
        context.delete(expense)
        saveIfNeeded()
    }
}
