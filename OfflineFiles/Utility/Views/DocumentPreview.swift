//
//  SwiftUIView.swift
//  OfflineFiles
//
//  Created by Abith Rajakumaran on 14/01/25.
//

import SwiftUI
import QuickLook

struct DocumentPreview: UIViewControllerRepresentable {
    let data: Data
    let fileExtension: String

    func makeCoordinator() -> Coordinator {
        Coordinator(data: data, fileExtension: fileExtension)
    }

    func makeUIViewController(context: Context) -> QLPreviewController {
        let controller = QLPreviewController()
        controller.dataSource = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: QLPreviewController, context: Context) {}

    class Coordinator: NSObject, QLPreviewControllerDataSource {
        let data: Data
        let fileExtension: String
        init(data: Data, fileExtension: String) {
            self.data = data
            self.fileExtension = fileExtension
        }

        func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            1
        }

        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("tempFile.\(fileExtension)")
            try? data.write(to: tempURL)
            return tempURL as NSURL
        }
    }
}

