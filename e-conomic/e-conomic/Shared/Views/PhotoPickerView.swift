//
//  PhotoPickerView.swift
//  e-conomic
//
//  Created by Dumitru Manea on 23.07.2024.
//

import SwiftUI

struct PhotoPickerView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    private let sourceType: UIImagePickerController.SourceType
    @Binding private var photoData: NSData?
    
    init(sourceType: UIImagePickerController.SourceType, photoData: Binding<NSData?>) {
        self.sourceType = sourceType
        self._photoData = photoData
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<PhotoPickerView>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator

        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<PhotoPickerView>) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        private let parent: PhotoPickerView

        init(parent: PhotoPickerView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.photoData = image.asNSData
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

#Preview {
    PhotoPickerView(sourceType: .camera, photoData: .constant(nil))
}
