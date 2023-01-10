//
//  ImagePickerView.swift
//  WatchConnectivitySample
//
//  Created by N. M on 2023/01/09.
//

import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePickerView

        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
        

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.editedImage] as? UIImage {
                parent.image = image.resize(size: CGSize(width: 100, height: 100))
            } else if let image = info[.originalImage] as? UIImage {
                parent.image = image.resize(size: CGSize(width: 100, height: 100))
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let viewController = UIImagePickerController()
        viewController.delegate = context.coordinator
        viewController.sourceType = UIImagePickerController.SourceType.photoLibrary
        viewController.allowsEditing = false
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
}
