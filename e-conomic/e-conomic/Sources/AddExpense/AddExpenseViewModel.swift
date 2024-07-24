//
//  AddExpenseViewModel.swift
//  e-conomic
//
//  Created by Dumitru Manea on 23.07.2024.
//

import Combine
import Foundation

protocol AddExpenseViewModelServicing: ObservableObject {
    var onSaveButtonTap: PassthroughSubject<Void, Never> { get }
    
    var title: String { get set }
    var details: String { get set }
    var currency: String { get set }
    var total: Double { get set }
    var photoData: NSData? { get set }
    var isShowingPhotoPickerView: Bool { get set }
    var availableCurrencies: [String] { get }
    
    func connect()
}

final class AddExpenseViewModel: AddExpenseViewModelServicing {
    // MARK: - Private properties
    private let dataManager: ExpensesDataManagerServicing
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Public properties
    let onSaveButtonTap = PassthroughSubject<Void, Never>()
    @Published var title: String
    @Published var details: String
    @Published var currency: String
    @Published var total: Double
    @Published var photoData: NSData?
    @Published var isShowingPhotoPickerView: Bool
    
    // MARK: - Initializer
    init(title: String = "",
         details: String = "",
         currency: String = Locale.current.currencyCode ?? "USD",
         total: Double = 0.0,
         photoData: NSData? = nil,
         isShowingPhotoPickerView: Bool = false,
         dataManager: ExpensesDataManagerServicing = ExpensesDataManager.shared) {
        self.title = title
        self.details = details
        self.currency = currency
        self.total = total
        self.photoData = photoData
        self.isShowingPhotoPickerView = isShowingPhotoPickerView
        self.dataManager = dataManager
    }
}

// MARK: - Computed properties
extension AddExpenseViewModel {
    var availableCurrencies: [String] {
        Locale.availableIdentifiers.compactMap { Locale(identifier: $0).currencyCode }
    }
}

// MARK: - Private methods
private extension AddExpenseViewModel {
    func addExpense() {
        dataManager.addExpense(
            title: title,
            details: details,
            total: total,
            currency: currency,
            date: Date(),
            photo: photoData)
    }
}

// MARK: - Public methods
extension AddExpenseViewModel {
    func connect() {
        onSaveButtonTap.sink { [unowned self] _ in
            addExpense()
        }
        .store(in: &subscriptions)
    }
}
