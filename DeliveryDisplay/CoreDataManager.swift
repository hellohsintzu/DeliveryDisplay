//
//  CoreDataManager.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/18.
//

import CoreData

final class CoreDataManager: NSObject {
    
    static let shared = CoreDataManager()
    
    private override init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "DeliveryDisplay")
        let description = NSPersistentStoreDescription()
        var sqlUrl = URL(fileURLWithPath: NSHomeDirectory())
        sqlUrl.appendPathComponent("Documents")
        sqlUrl.appendPathComponent("program.sqlite")
        description.url = sqlUrl
        persistentContainer.persistentStoreDescriptions = [description]
        persistentContainer.loadPersistentStores { _, error in
            print(error?.localizedDescription ?? "")
        }
        return persistentContainer
    }()
    
    func managedObjectContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

