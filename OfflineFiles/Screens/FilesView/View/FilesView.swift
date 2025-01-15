//
//  FilesView.swift
//  OfflineFiles
//
//  Created by Abith Rajakumaran on 13/01/25.
//

import SwiftUI
import PhotosUI

struct FilesView: View {
    @State var viewModel: FilesViewModel = FilesViewModel.init()
    let columns = [GridItem(.adaptive(minimum: 80))]
    var folderEntity: FolderEntity?
    var refresh: () -> Void
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    if let filesEntity = folderEntity?.files?.allObjects as? [FileEntity] {
                        ForEach(filesEntity) { file in
                            ContentView(
                                file: file,
                                imageTap: viewModel.onImageTap(uiImage:)
                            )
                            .contextMenu {
                                Button {
                                    viewModel.deleteFile(file, refresh: refresh)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                }
            }
            
            Button {
                viewModel.displayDialog = true
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 80)
                        
                    Text(StringConstant.uploadButton)
                        .foregroundStyle(Color.white)
                        .font(.headline)
                        
                }
            }

        }
        .navigationTitle(folderEntity?.name ?? "")
        .onAppear {
            viewModel.folderEntity = folderEntity
        }
        .confirmationDialog("", isPresented: $viewModel.displayDialog) {
            Button(StringConstant.uploadFile) {
                viewModel.importIsPresented = true
            }
            
            Button(StringConstant.uploadPhoto) {
                viewModel.displayImagePicker = true
            }

        }
        .photosPicker(
            isPresented: $viewModel.displayImagePicker,
            selection: $viewModel.selectedImageItem
        )
        .fileImporter(
            isPresented: $viewModel.importIsPresented,
            allowedContentTypes: [.item],
            onCompletion: viewModel.saveFileData
        )
        .sheet(
            isPresented: $viewModel.displayImage
        ) {
            ImagePreview(uiImage: viewModel.avatarImage)
        }
    }
}

#Preview {
    FilesView(refresh: {
        
    })
}
