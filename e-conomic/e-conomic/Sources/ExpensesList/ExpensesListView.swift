//
//  ExpensesListView.swift
//  e-conomic
//
//  Created by Dumitru Manea on 23.07.2024.
//

import SwiftUI

struct ExpensesListView: View {
    private let theme: ExpensesListViewTheme
    @ObservedObject private var viewModel: ExpensesListViewModel
    
    init(theme: ExpensesListViewTheme = ExpensesListViewThemeItem(), viewModel: ExpensesListViewModel = ExpensesListViewModel()) {
        self.theme = theme
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0...1000, id: \.self) {
                    Text("Number: \($0)")
                }
            }
            .navigationTitle("e-conomic")
            .toolbar {
                ToolbarItem {
                    Button {
                        viewModel.isShowingAddExpenseView.toggle()
                    } label: {
                        Text("Add Expense")
                            .foregroundColor(Color.eConomicPrimary)
                    }
                }
            }
            .sheet(isPresented: $viewModel.isShowingAddExpenseView) {
                AddExpenseView()
            }
        }
    }
}

#Preview {
    ExpensesListView()
}
