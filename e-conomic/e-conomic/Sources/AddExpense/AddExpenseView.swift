//
//  AddExpenseView.swift
//  e-conomic
//
//  Created by Dumitru Manea on 23.07.2024.
//

import SwiftUI

struct AddExpenseView: View {
    private let theme: AddExpenseViewTheme
    @ObservedObject private var viewModel: AddExpenseViewModel
    
    init(theme: AddExpenseViewTheme = AddExpenseViewThemeItem(), viewModel: AddExpenseViewModel = AddExpenseViewModel()) {
        self.theme = theme
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Title") {
                    TextField("Enter your title here", text: $viewModel.title)
                }
                
                Section(header: Text("Details"), footer: Text("Details are optional.")) {
                    TextEditor(text: $viewModel.details)
                }
                
                Section("Currency") {
                    Picker("Select your currency", selection: $viewModel.currency) {
                        ForEach(viewModel.availableCurrencies, id: \.self) { currency in
                            Text(currency)
                        }
                    }
                }
                
                Section("Total") {
                    TextField("How much you spent?", value: $viewModel.total, format: .number)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button {
                    print("Save")
                } label: {
                    Text("Save")
                        .foregroundColor(Color.eConomicPrimary)
                }
            }
        }
    }
}

#Preview {
    AddExpenseView()
}
