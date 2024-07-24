//
//  ExpenseDetailsViewTheme.swift
//  e-conomic
//
//  Created by Dumitru Manea on 23.07.2024.
//

import SwiftUI
import Foundation

protocol ExpenseDetailsViewTheme: ExpenseDetailsViewThemeStringsServicing, ExpenseDetailsViewThemeStyleServicing { }

protocol ExpenseDetailsViewThemeStringsServicing {
    var navBarTitle: String { get }
    var totalTitle: String { get }
    var dateTitle: String { get }
}

protocol ExpenseDetailsViewThemeStyleServicing {
    var placeholderImage: Image { get }
    var titleFont: Font { get }
    var titleColor: Color { get }
    var detailsFont: Font { get }
    var detailsColor: Color { get }
    var totalFont: Font { get }
    var totalColor: Color { get }
    var dateFont: Font { get }
    var dateColor: Color { get }
}

struct ExpenseDetailsViewThemeItem: ExpenseDetailsViewTheme { }

// MARK: - String servicing
extension ExpenseDetailsViewThemeItem {
    var navBarTitle: String {
        "Expense Details"
    }
    
    var totalTitle: String {
        "Total:"
    }
    
    var dateTitle: String {
        "Date:"
    }
}

// MARK: - Style servicing
extension ExpenseDetailsViewThemeItem: ExpenseDetailsViewThemeStyleServicing {
    var placeholderImage: Image {
        Image("ExpensePlaceholderImage")
    }
    
    var textFont: Font {
        Font.system(size: 16, weight: .medium)
    }
    
    var textColor: Color {
        Color.eConomicTertiary
    }
    
    var titleFont: Font {
        Font.title
    }
    
    var titleColor: Color {
        Color.eConomicPrimary
    }
    
    var detailsFont: Font {
        Font.body
    }
    
    var detailsColor: Color {
        Color.eConomicTertiary
    }
    
    var totalFont: Font {
        Font.body
    }
    
    var totalColor: Color {
        Color.eConomicTertiary
    }
    
    var dateFont: Font {
        Font.body
    }
    
    var dateColor: Color {
        Color.eConomicTertiary
    }
}
