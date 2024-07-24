//
//  Expense.swift
//  e-conomic
//
//  Created by Dumitru Manea on 23.07.2024.
//

import CoreData

protocol ExpensePresentable {
    var title: String { get set }
    var details: String { get set }
    var total: Double { get set }
    var currency: String { get set }
    var date: Date { get set }
    var photo: NSData? { get set }
}

final class Expense: NSManagedObject, ExpensePresentable {
    @NSManaged var title: String
    @NSManaged var details: String
    @NSManaged var total: Double
    @NSManaged var currency: String
    @NSManaged var date: Date
    @NSManaged var photo: NSData?
    
    @available(*, unavailable)
    init() {
        fatalError()
    }

    @available(*, unavailable)
    init(context: NSManagedObjectContext) {
        fatalError()
    }
    
    @objc override private init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init(context: NSManagedObjectContext,
         title: String,
         details: String,
         total: Double,
         currency: String,
         date: Date,
         photo: NSData?) {
        let entity = NSEntityDescription.entity(forEntityName: String.init(describing: Self.self), in: context)!
        super.init(entity: entity, insertInto: context)
        self.title = title
        self.details = details
        self.total = total
        self.currency = currency
        self.date = date
        self.photo = photo
    }
    
    
}
