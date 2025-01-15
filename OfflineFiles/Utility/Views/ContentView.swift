//
//  ContentView.swift
//  OfflineFiles
//
//  Created by Abith Rajakumaran on 15/01/25.
//

import SwiftUI

struct ContentView: View {
    var file: FileEntity
    var imageTap: (UIImage) -> Void
    var body: some View {
        if file.type == "img",
           let content = file.content,
           let uiImage = UIImage(data: content) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 100)
                .onTapGesture {
                    imageTap(uiImage)
                }
        } else if let content = file.content,
                    let type = file.type,
                    let name = file.name {
            NavigationLink {
                DocumentPreview(
                    data: content,
                    fileExtension: type
                )
                .navigationTitle(name)
            } label: {
                VStack {
                    Image("file")
                        .resizable()
                        .frame(width: 60, height: 60)
                    Text(file.name ?? "")
                        .font(.caption)
                }
                .frame(width: 80, height: 100)
            }
        }
        
    }
}
