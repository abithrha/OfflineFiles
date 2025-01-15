//
//  CoreDataManager.swift
//  OfflineFiles
//
//  Created by Abith Rajakumaran on 09/01/25.
//

import Foundation
import CoreData

public class CoreDataManager {
    
    static let shared = CoreDataManager.init()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    private init() {
        container = NSPersistentContainer.init(name: "CoreDataModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error in fetching data \(error)")
            }
        }
        context = container.viewContext
    }
    
    
    func fetchFolder(sortby: SortOption, _ completion: @escaping ([FolderEntity]) -> Void) {
        let fetchFolders: NSFetchRequest<FolderEntity> = FolderEntity.fetchRequest()
        if sortby != .none {
            let keyPath = configKeyPath(option: sortby)
            let isAscending = (sortby == .ascending)
            fetchFolders.sortDescriptors = [NSSortDescriptor(key: keyPath, ascending: isAscending)]
        }
        do {
            let savedFolders = try container.viewContext.fetch(fetchFolders)
            completion(savedFolders)
        } catch let error {
            print("Error in fetching data \(error)")
        }
    }
    
    func save() {
        do {
            try context.save()
        } catch let error {
            print("Error in saving data \(error)")
        }
    }
    
    func configKeyPath(option: SortOption) -> String {
        switch option {
        case .createdDate:
            return "creationDate"
        case .ascending, .descending:
            return "name"
        case .none:
            return ""
        }
    }
}
