//
//  AddExpenseViewTheme.swift
//  e-conomic
//
//  Created by Dumitru Manea on 23.07.2024.
//

import SwiftUI
import Foundation

protocol AddExpenseViewTheme: AddExpenseViewThemeStringsServicing, AddExpenseViewThemeStyleServicing { }

protocol AddExpenseViewThemeStringsServicing {
    var navBarTitle: String { get }
    var leftBarButtonTitle: String { get }
    var rightBarButtonTitle: String { get }
    var titleSectionHeaderText: String { get }
    var titleTextFieldPlaceholderText: String { get }
    var detailsSectionHeaderText: String { get }
    var detailsSectionsFooterText: String { get }
    var currencySectionHeaderText: String { get }
    var currencyPickerText: String { get }
    var totalSectionHeaderText: String { get }
    var totalTextFieldPlaceholderText: String { get }
    var photoSectionHeaderText: String { get }
    var photoSectionButtonTitle: String { get }
}

protocol AddExpenseViewThemeStyleServicing {
    var leftBarButtonColor: Color { get }
    var rightBarButtonColor: Color { get }
    var formTintColor: Color { get }
    var photoSectionBackgroundColor: Color { get }
    var photoButtonTitleFont: Font { get }
    var photoButtonTitleColor: Color { get }
}

struct AddExpenseViewThemeItem: AddExpenseViewTheme { }

// MARK: - Strings servicing
extension AddExpenseViewThemeItem {
    var navBarTitle: String {
        "Add new expense"
    }
    
    var leftBarButtonTitle: String {
        "Cancel"
    }
    
    var rightBarButtonTitle: String {
        "Save"
    }
    
    var titleSectionHeaderText: String {
        "Title"
    }
    
    var titleTextFieldPlaceholderText: String {
        "Enter your expense title here"
    }
    
    var detailsSectionHeaderText: String {
        "Details"
    }
    
    var detailsSectionsFooterText: String {
        "Details are optional"
    }
    
    var currencySectionHeaderText: String {
        "Currency"
    }
    
    var currencyPickerText: String {
        "Select your expense currency"
    }
    
    var totalSectionHeaderText: String {
        "Total"
    }
    
    var totalTextFieldPlaceholderText: String {
        "How much you spent?"
    }
    
    var photoSectionHeaderText: String {
        "Photo"
    }
    
    var photoSectionButtonTitle: String {
        "Take a photo of your expense"
    }
}

// MARK: - Style servicing
extension AddExpenseViewThemeItem {
    var leftBarButtonColor: Color {
        Color.eConomicPrimary
    }
    var rightBarButtonColor: Color {
        Color.eConomicPrimary
    }
    
    var formTintColor: Color {
        Color.eConomicTertiary
    }
    
    var photoSectionBackgroundColor: Color {
        Color.eConomicTertiary
    }
    
    var photoButtonTitleFont: Font {
        Font.system(size: 16, weight: .medium)
    }
    
    var photoButtonTitleColor: Color {
        Color.eConomicSecondary
    }
}
