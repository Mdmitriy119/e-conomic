//
//  ExpenseDetailsViewModel.swift
//  e-conomic
//
//  Created by Dumitru Manea on 24.07.2024.
//

import Foundation

protocol ExpenseDetailsViewModelServicing {
    var expense: ExpensePresentable { get }
}

struct ExpenseDetailsViewModel: ExpenseDetailsViewModelServicing {
    let expense: ExpensePresentable
    
    init(expense: ExpensePresentable) {
        self.expense = expense
    }
}
