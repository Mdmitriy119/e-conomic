//
//  ExpenseDetailsView.swift
//  e-conomic
//
//  Created by Dumitru Manea on 23.07.2024.
//

import SwiftUI

struct ExpenseDetailsView: View {
    private let theme: ExpenseDetailsViewTheme
    private let viewModel: ExpenseDetailsViewModelServicing
    
    init(theme: ExpenseDetailsViewTheme = ExpenseDetailsViewThemeItem(),
         viewModel: ExpenseDetailsViewModelServicing) {
        self.theme = theme
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Group {
                if let photoData = viewModel.expense.photo, let uiImage = UIImage(data: photoData as Data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                } else {
                    theme.placeholderImage
                        .resizable()
                        .scaledToFit()
                }
            }
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
            
            if !viewModel.expense.title.isEmpty {
                Text(viewModel.expense.title)
                    .font(theme.titleFont)
                    .foregroundColor(theme.titleColor)
            }
            
            if !viewModel.expense.details.isEmpty {
                Text(viewModel.expense.details)
                    .font(theme.detailsFont)
                    .foregroundColor(theme.detailsColor)
            }
            
            HStack {
                Text(theme.totalTitle)
                    .font(theme.totalFont.bold())
                Text("\(viewModel.expense.total.stringWith2Decimals) \(viewModel.expense.currency)")
                    .font(theme.totalFont)
            }
            .foregroundColor(theme.totalColor)
            
            HStack {
                Text(theme.dateTitle)
                    .font(theme.dateFont.bold())
                Text(viewModel.expense.date, style: .date)
                    .font(theme.dateFont)
            }
            .foregroundColor(theme.dateColor)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding()
        .navigationTitle(theme.navBarTitle)
    }
}


// MARK: - Preview
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

#Preview {
    let mockExpense = MockExpense(
        title: "Parking expense",
        details: "Monthly parking expense at Palas mall",
        total: 240.0,
        currency: "RON", date: Date())
    let viewModel = ExpenseDetailsViewModel(expense: mockExpense)
    return ExpenseDetailsView(viewModel: viewModel)
}



