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
    
    
    func fetchFolder(_ completion: @escaping ([FolderEntity]) -> Void) {
        let fetchFolders = NSFetchRequest<FolderEntity>(entityName: "FolderEntity")
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
    
}
