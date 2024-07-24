//
//  ExpensesListViewTheme.swift
//  e-conomic
//
//  Created by Dumitru Manea on 23.07.2024.
//

import SwiftUI

protocol ExpensesListViewTheme: ExpensesListViewThemeStringsServicing, ExpensesListViewThemeStyleServicing { }

protocol ExpensesListViewThemeStringsServicing {
    var navBarTitle: String { get }
    var rightBarButtonTitle: String { get }
}

protocol ExpensesListViewThemeStyleServicing {
    var rightBarButtonTitleColor: Color { get }
    var placeholderImage: Image { get }
    var imageSize: CGFloat { get }
    var titleFont: Font { get }
    var titleColor: Color { get }
    var totalFont: Font { get }
    var totalColor: Color { get }
}


struct ExpensesListViewThemeItem: ExpensesListViewTheme { }

// MARK: - String servicing
extension ExpensesListViewThemeItem {
    var navBarTitle: String {
        "e-conomic"
    }
    
    var rightBarButtonTitle: String {
        "Add Expense"
    }
}

// MARK: - Style servicing
extension ExpensesListViewTheme {
    var navigationViewAccentColor: Color {
        Color.eConomicPrimary
    }
    
    var rightBarButtonTitleColor: Color {
        Color.eConomicPrimary
    }
    
    var placeholderImage: Image {
        Image("ExpensePlaceholderImage")
    }
    
    var imageSize: CGFloat {
        50.0
    }
    
    var titleFont: Font {
        Font.system(size: 20, weight: .medium)
    }
    
    var titleColor: Color {
        Color.eConomicTertiary
    }
    
    var totalFont: Font {
        Font.system(size: 14, weight: .regular)
    }
    
    var totalColor: Color {
        Color.eConomicTertiary
    }
}
