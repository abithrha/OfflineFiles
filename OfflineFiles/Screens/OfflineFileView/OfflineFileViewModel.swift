//
//  OfflineFileViewModel.swift
//  OfflineFiles
//
//  Created by Abith Rajakumaran on 09/01/25.
//

import Foundation
import Observation

@Observable
public class OfflineFileViewModel {
    let coredataManager: CoreDataManager = CoreDataManager.shared
    var folderName: String               = "Hello World"
    var folderColor: String              = ""
    var isFavoriteFolder: Bool           = false
    var folderCreationDate: Date         = Date()
    var folders: [FolderEntity]          = []
    
    init() {
//        addFolder()
        coredataManager.fetchFolder { data in
            self.folders = data
        }
    }
    
    
    func addFolder() {
        let newFolder = FolderEntity(context: coredataManager.context)
        newFolder.name = folderName
        newFolder.creationDate = folderCreationDate
        newFolder.color = folderColor
        newFolder.isFavorite = isFavoriteFolder
        coredataManager.save()
        coredataManager.fetchFolder { data in
            self.folders = data
        }
        resetFolderSettings()
    }
    
    func resetFolderSettings() {
        folderName         = ""
        folderColor        = ""
        isFavoriteFolder   = false
        folderCreationDate = Date()
    }
}
