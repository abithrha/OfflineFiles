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
    
    init() {
        
        coredataManager.fetchFolder { data in
            self.folders = data
//            for folder in self.folders {
//                self.coredataManager.context.delete(folder)
//            }
//            self.coredataManager.save()
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
        coredataManager.save()
        coredataManager.fetchFolder { data in
            self.folders = data
        }
        resetFolderSettings()
    }
    
    func resetFolderSettings() {
        folderName         = ""
        folderColor        = Color.blue
        isFavoriteFolder   = false
        folderCreationDate = Date()
    }
}
