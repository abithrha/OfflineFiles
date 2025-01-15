//
//  FilesViewModel.swift
//  OfflineFiles
//
//  Created by Abith Rajakumaran on 14/01/25.
//

import SwiftUI
import PhotosUI
import Foundation
import Observation

@Observable
public class FilesViewModel {
    var importIsPresented: Bool     = false
    var avatarImage: UIImage?       = nil
    var persentPerview: Bool        = false
    var selectedData: FileEntity?   = nil
    var displayDialog: Bool         = false
    var displayImagePicker: Bool    = false
    var displayImage: Bool          = false
    var folderEntity: FolderEntity? = nil
    let coreDataManager             = CoreDataManager.shared
    
    var selectedImageItem: PhotosPickerItem? = nil {
        didSet {
            Task {
                await saveImgData(from: selectedImageItem)
            }
        }
    }
    
    func onImageTap(uiImage: UIImage) {
        avatarImage  = uiImage
        displayImage = true
    }
    
    func deleteFile(_ file: FileEntity, refresh: () -> Void) {
        coreDataManager.context.delete(file)
        refresh()
    }
    
    func saveImgData(from selection: PhotosPickerItem?) async {
        guard let selection else { return }
        do {
            if let content = try await selection.loadTransferable(type: Data.self) {
                let fileEntity = FileEntity(context: coreDataManager.context)
                fileEntity.content = content
                fileEntity.name = Int.random(in: 1...10).description
                fileEntity.type = "img"
                folderEntity?.addToFiles(fileEntity)
                coreDataManager.save()
            }
        } catch {
            print(error)
        }
    }
    
    func saveFileData(result: Result<URL, any Error>) {
        do {
            let fileEntity = FileEntity(context: coreDataManager.context)
            let content = try Data(contentsOf: result.get())
            let fileUrl = try result.get()
            fileEntity.content = content
            fileEntity.name = fileUrl.lastPathComponent
            fileEntity.type = fileUrl.pathExtension
            folderEntity?.addToFiles(fileEntity)
            coreDataManager.save()
        } catch {
            print(error)
        }
    }
}
