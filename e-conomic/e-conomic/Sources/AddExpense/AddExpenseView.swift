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
    @Environment(\.presentationMode) var presentationMode
    
    init(theme: AddExpenseViewTheme = AddExpenseViewThemeItem(),
         viewModel: AddExpenseViewModel = AddExpenseViewModel()) {
        self.theme = theme
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            Form {
                titleSection
                detailsSection
                currencySection
                totalSection
                photoSection
            }
            .tint(Color.eConomicTertiary)
            .navigationTitle(theme.navBarTitle)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    leftBarButtonView
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    rightBarButtonView
                }
            }
            .sheet(isPresented: $viewModel.isShowingPhotoPickerView) {
                PhotoPickerView(sourceType: .camera, photoData: $viewModel.photoData)
                    .edgesIgnoringSafeArea(.bottom)
            }
        }
        .onAppear {
            viewModel.connect()
        }
    }
}

// MARK: - Navigation bar components
private extension AddExpenseView {
    var leftBarButtonView: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text(theme.leftBarButtonTitle)
                .foregroundColor(theme.leftBarButtonColor)
        }
    }
    
    var rightBarButtonView: some View {
        Button {
            viewModel.onSaveButtonTap.send()
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text(theme.rightBarButtonTitle)
                .foregroundColor(theme.rightBarButtonColor)
        }
    }
}

// MARK: - Form components
private extension AddExpenseView {
    var titleSection: some View {
        Section(theme.titleSectionHeaderText) {
            TextField(theme.titleTextFieldPlaceholderText, text: $viewModel.title)
        }
    }
    
    var detailsSection: some View {
        Section(header: Text(theme.detailsSectionHeaderText), footer: Text(theme.detailsSectionsFooterText)) {
            TextEditor(text: $viewModel.details)
        }
    }
    
    var currencySection: some View {
        Section(theme.currencySectionHeaderText) {
            Picker(theme.currencyPickerText, selection: $viewModel.currency) {
                ForEach(viewModel.availableCurrencies, id: \.self) { currency in
                    Text(currency)
                }
            }
        }
    }
    
    var totalSection: some View {
        Section(theme.totalSectionHeaderText) {
            TextField(theme.totalTextFieldPlaceholderText, value: $viewModel.total, format: .number)
                .keyboardType(.decimalPad)
        }
    }
    
    var photoSection: some View {
        Section(theme.photoSectionHeaderText) {
            VStack(alignment: .center) {
                Button {
                    viewModel.isShowingPhotoPickerView.toggle()
                } label: {
                    Text(theme.photoSectionButtonTitle)
                        .font(theme.photoButtonTitleFont)
                        .foregroundColor(theme.photoButtonTitleColor)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                if let photoData = viewModel.photoData,
                   let uiImage = UIImage(data: Data(referencing: photoData)) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                }
            }
        }
        .listRowBackground(theme.photoSectionBackgroundColor)
    }
}


#Preview {
    AddExpenseView()
}
