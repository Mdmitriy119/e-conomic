//
//  ImagePickerView.swift
//  e-conomic
//
//  Created by Dumitru Manea on 23.07.2024.
//

import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    private let sourceType: UIImagePickerController.SourceType
    @Binding private var selectedImage: UIImage?
    
    init(sourceType: UIImagePickerController.SourceType, selectedImage: Binding<UIImage?>) {
        self.sourceType = sourceType
        self._selectedImage = selectedImage
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator

        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerView>) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        private let parent: ImagePickerView

        init(parent: ImagePickerView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

#Preview {
    ImagePickerView(sourceType: .camera, selectedImage: .constant(UIImage()))
}
