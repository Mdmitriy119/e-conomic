//
//  ExpensesDataManager.swift
//  e-conomic
//
//  Created by Dumitru Manea on 23.07.2024.
//

import CoreData

protocol ExpensesDataManagerServicing {
    var fetchResultsController: NSFetchedResultsController<Expense> { get }
    
    func addExpense(title: String,
                    details: String,
                    total: Double,
                    currency: String,
                    date: Date,
                    photo: NSData?)
    func delete(expense: ExpensePresentable)
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
    lazy var fetchResultsController: NSFetchedResultsController<Expense> = {
        let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest() as! NSFetchRequest<Expense>
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: persistentContainer.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
    }()
    
    // MARK: - Initializer
    private init() {
        persistentContainer = NSPersistentContainer(name: containerName)
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error {
                fatalError(error.localizedDescription)
            }
        }
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
    
    func delete(expense: ExpensePresentable) {
        if let expense = expense as? Expense {
            context.delete(expense)
            saveIfNeeded()
        }
    }
}
