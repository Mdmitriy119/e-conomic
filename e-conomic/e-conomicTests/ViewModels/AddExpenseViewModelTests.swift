//
//  AddExpenseViewModelTests.swift
//  e-conomicTests
//
//  Created by Dumitru Manea on 24.07.2024.
//

import XCTest
import Combine
import CoreData
@testable import e_conomic

final class AddExpenseViewModelTests: XCTestCase {
    private var viewModel: AddExpenseViewModel!
    private var mockDataManager: MockExpensesDataManager!
    
    override func setUp() {
        super.setUp()
        mockDataManager = MockExpensesDataManager()
        viewModel = AddExpenseViewModel(dataManager: mockDataManager)
    }
    
    override func tearDown() {
        viewModel = nil
        mockDataManager = nil
        super.tearDown()
    }
    
    func testInitialValues() {
        XCTAssertEqual(viewModel.title, "")
        XCTAssertEqual(viewModel.details, "")
        XCTAssertEqual(viewModel.total, 0.0)
        XCTAssertEqual(viewModel.currency, Locale.current.currencyCode ?? "USD")
        XCTAssertNil(viewModel.photoData)
        XCTAssertFalse(viewModel.isShowingPhotoPickerView)
    }
    
    func testAvailableCurrencies() {
        let currencies = viewModel.availableCurrencies
        XCTAssertTrue(currencies.contains("USD"))
        XCTAssertTrue(currencies.contains("EUR"))
    }
    
    func testAddExpense() {
        // Given
        viewModel.connect()
        viewModel.title = "Test Expense"
        viewModel.details = "Test Details"
        viewModel.total = 123.45
        viewModel.currency = "USD"
        
        // When
        viewModel.onSaveButtonTap.send(())
        
        // Then
        XCTAssertTrue(mockDataManager.addExpenseCalled)
        XCTAssertEqual(mockDataManager.addedExpense?.title, "Test Expense")
        XCTAssertEqual(mockDataManager.addedExpense?.details, "Test Details")
        XCTAssertEqual(mockDataManager.addedExpense?.total, 123.45)
        XCTAssertEqual(mockDataManager.addedExpense?.currency, "USD")
    }
    
    func testDeleteExpense() {
        // Given
        let expense = MockExpense(title: "Test Expense", details: "", total: 0.0, currency: "RON", date: Date())
        
        // When
        mockDataManager.delete(expense: expense)
        
        // Then
        XCTAssertTrue(mockDataManager.deleteExpenseCalled)
        XCTAssertEqual(mockDataManager.deletedExpense?.title, "Test Expense")
    }
}

private struct MockExpense: ExpensePresentable {
    var title: String
    var details: String
    var total: Double
    var currency: String
    var date: Date
    var photo: NSData?
    
    init(title: String, details: String, total: Double, currency: String, date: Date, photo: NSData? = nil) {
        self.title = title
        self.details = details
        self.total = total
        self.currency = currency
        self.date = date
        self.photo = photo
    }
}

private final class MockExpensesDataManager: ExpensesDataManagerServicing {
    var fetchResultsController: NSFetchedResultsController<Expense> {
        let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest() as! NSFetchRequest<Expense>
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        return NSFetchedResultsController(fetchRequest: fetchRequest,
                                          managedObjectContext: context,
                                          sectionNameKeyPath: nil,
                                          cacheName: nil)
    }

    var addExpenseCalled = false
    var addedExpense: (title: String, details: String, total: Double, currency: String, date: Date, photo: NSData?)?
    
    var deleteExpenseCalled = false
    var deletedExpense: ExpensePresentable?

    func addExpense(title: String, details: String, total: Double, currency: String, date: Date, photo: NSData?) {
        addExpenseCalled = true
        addedExpense = (title, details, total, currency, date, photo)
    }

    func delete(expense: ExpensePresentable) {
        deleteExpenseCalled = true
        deletedExpense = expense
    }
}
