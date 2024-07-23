//
//  AddExpenseViewModel.swift
//  e-conomic
//
//  Created by Dumitru Manea on 23.07.2024.
//

import Foundation

protocol AddExpenseViewModelServicing: ObservableObject {
    var title: String { get set }
    var details: String { get set }
    var currency: String { get set }
    var total: Double { get set }
    var availableCurrencies: [String] { get }
}

final class AddExpenseViewModel: AddExpenseViewModelServicing {
    @Published var title: String = ""
    @Published var details: String = ""
    @Published var currency: String = "USD"
    @Published var total: Double = 0.0
    var availableCurrencies: [String] = ["USD", "EUR", "GBP", "RON", "MDL"]
}
