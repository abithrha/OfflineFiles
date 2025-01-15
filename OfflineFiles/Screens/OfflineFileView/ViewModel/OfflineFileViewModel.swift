//
//  OfflineFileViewModel.swift
//  OfflineFiles
//
//  Created by Abith Rajakumaran on 09/01/25.
//

import SwiftUI
import Foundation
import Observation

@Observable
public class OfflineFileViewModel {
    let coredataManager: CoreDataManager = CoreDataManager.shared
    var folderName: String               = ""
    var folderColor: Color               = Color.blue
    var isFavoriteFolder: Bool           = false
    var displayFolderAlert: Bool         = false
    var folderCreationDate: Date         = Date()
    var sortby: SortOption               = .none
    var folders: [FolderEntity]          = []
    var favoriteFolder: [FolderEntity]   = []
    
    init() {
        saveAndFetchFolderData(save: false)
    }
    
    func toggleFavorite(for folder: FolderEntity) {
        folder.isFavorite.toggle()
        saveAndFetchFolderData()
    }
    
    func deleteFolder(_ folder: FolderEntity) {
        coredataManager.context.delete(folder)
        saveAndFetchFolderData()
    }
    
    func sortFolders(sort: SortOption) {
        UserDefaults.standard.setSortOption(sort)
        coredataManager.fetchFolder(sortby: sort) { data in
            self.folders = data
            self.favoriteFolder = data.filter({ $0.isFavorite })
        }
    }
    
    func addFolder() {
        let newFolder = FolderEntity(context: coredataManager.context)
        
        let existingNameCount = folders.filter { folder in
            let name = folder.name?.contains(folderName)
            if name ?? false {
                let currentName = folder.name?.prefix(upTo: folderName.endIndex) ?? ""
                return currentName == folderName
            }
            return false
        }.count
        
        newFolder.name = existingNameCount == 0 ? folderName : "\(folderName) (\(existingNameCount))"
        newFolder.creationDate = folderCreationDate
        newFolder.color = folderColor.toHex() ?? ""
        newFolder.isFavorite = isFavoriteFolder
        saveAndFetchFolderData()
        resetFolderSettings()
    }
    
    func saveAndFetchFolderData(save: Bool = true) {
        if save {
            coredataManager.save()
        }
        coredataManager.fetchFolder(sortby: UserDefaults.standard.getSortOption()) { data in
            self.folders = data
            self.favoriteFolder = data.filter({ $0.isFavorite })
        }
    }
    
    func resetFolderSettings() {
        folderName         = ""
        folderColor        = Color.blue
        isFavoriteFolder   = false
        folderCreationDate = Date()
    }
}
