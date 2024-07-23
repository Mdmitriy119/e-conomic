//
//  ExpensesListViewModel.swift
//  e-conomic
//
//  Created by Dumitru Manea on 23.07.2024.
//

import Foundation

protocol ExpensesListViewModelServicing: ObservableObject {
    var isShowingAddExpenseView: Bool { get set }
}

final class ExpensesListViewModel: ExpensesListViewModelServicing {
    @Published var isShowingAddExpenseView: Bool = false

    init() {
        
    }
}
