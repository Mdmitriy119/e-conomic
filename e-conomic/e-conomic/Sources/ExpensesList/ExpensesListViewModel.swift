//
//  ExpensesListViewModel.swift
//  e-conomic
//
//  Created by Dumitru Manea on 23.07.2024.
//

import CoreData

protocol ExpensesListViewModelServicing: ObservableObject {
    var expenses: [ExpensePresentable] { get set }
    var isShowingAddExpenseView: Bool { get set }
    
    func connect()
    func deleteExpenses(at offsets: IndexSet)
}

final class ExpensesListViewModel: NSObject, ExpensesListViewModelServicing {
    // MARK: - Private properties
    private let dataManager: ExpensesDataManagerServicing
    
    // MARK: - Public properties
    @Published var isShowingAddExpenseView: Bool = false
    @Published var expenses: [ExpensePresentable] = []
    
    // MARK: - Initializer
    init(isShowingAddExpenseView: Bool = false,
         expenses: [ExpensePresentable] = [],
         dataManager: ExpensesDataManagerServicing = ExpensesDataManager.shared) {
        self.isShowingAddExpenseView = isShowingAddExpenseView
        self.expenses = expenses
        self.dataManager = dataManager
        super.init()
    }
}
 
// MARK: - Public methods
extension ExpensesListViewModel {
    func connect() {
        dataManager.fetchResultsController.delegate = self
        try? dataManager.fetchResultsController.performFetch()
        expenses = dataManager.fetchResultsController.fetchedObjects ?? []
    }
    
    func deleteExpenses(at offsets: IndexSet) {
        for offset in offsets {
            if let expense = expenses[offset] as? Expense {
                dataManager.delete(expense: expense)
            }
        }
    }
}

// MARK: - NSFetchedResultsControllerDelegate
extension ExpensesListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        expenses = controller.fetchedObjects as? [ExpensePresentable] ?? []
    }
}
