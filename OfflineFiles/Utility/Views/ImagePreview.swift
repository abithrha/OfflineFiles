//
//  ImagePreview.swift
//  OfflineFiles
//
//  Created by Abith Rajakumaran on 14/01/25.
//

import SwiftUI

struct ImagePreview: View {
    let uiImage: UIImage?
    var body: some View {
        if let uiImage = uiImage {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 2)
        }
    }
}

#Preview {
    ImagePreview(uiImage: nil)
}
