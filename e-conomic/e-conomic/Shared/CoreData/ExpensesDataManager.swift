//
//  ExpensesDataManager.swift
//  e-conomic
//
//  Created by Dumitru Manea on 23.07.2024.
//

import CoreData

final class ExpensesDataManager {
    private let persistentContainer: NSPersistentContainer
    
    static let shared = ExpensesDataManager()
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "ExpensesDataModel")
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error{
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}
