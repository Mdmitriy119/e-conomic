//
//  ExpensesListView.swift
//  e-conomic
//
//  Created by Dumitru Manea on 23.07.2024.
//

import SwiftUI

struct ExpensesListView<VM: ExpensesListViewModelServicing>: View {
    private let theme: ExpensesListViewTheme
    @ObservedObject private var viewModel: VM
    
    init(theme: ExpensesListViewTheme = ExpensesListViewThemeItem(),
         viewModel: VM = ExpensesListViewModel()) {
        self.theme = theme
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.expenses, id: \.self) { expense in
                    NavigationLink {
                        ExpenseDetailsView()
                    } label: {
                        expenseView(for: expense)
                    }
                }
            }
            .navigationTitle(theme.navBarTitle)
            .toolbar {
                ToolbarItem {
                    rightBarButtonView
                }
            }
            .sheet(isPresented: $viewModel.isShowingAddExpenseView) {
                AddExpenseView()
            }
        }
        .accentColor(theme.navigationViewAccentColor)
        .onAppear {
            viewModel.connect()
        }
    }
}

// MARK: - Sub-components
private extension ExpensesListView {
    var rightBarButtonView: some View {
        Button {
            viewModel.isShowingAddExpenseView.toggle()
        } label: {
            Text(theme.rightBarButtonTitle)
                .foregroundColor(theme.rightBarButtonTitleColor)
        }
    }
    
    func expenseView(for expense: Expense) -> some View {
        HStack {
            Group {
                if let photoData = expense.photo,
                   let uiImage = UIImage(data: Data(referencing: photoData)) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    theme.placeholderImage
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
            .frame(width: theme.imageSize, height: theme.imageSize)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(expense.title)
                    .font(theme.titleFont)
                    .foregroundColor(theme.titleColor)
                
                Text("\(expense.total.stringWith2Decimals) \(expense.currency)")
                    .font(theme.totalFont)
                    .foregroundColor(theme.totalColor)
            }
        }
    }
}

#Preview {
    ExpensesListView()
}
