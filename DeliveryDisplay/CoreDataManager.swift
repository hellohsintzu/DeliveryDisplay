//
//  CoreDataManager.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/18.
//

import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "DeliveryDisplay")
        persistentContainer.loadPersistentStores { _, error in
            print(error?.localizedDescription ?? "")
        }
        return persistentContainer
    }()
    
    lazy var moc: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    func get<T: NSManagedObject>(_ id: NSManagedObjectID) -> T? {
        do {
            return try moc.existingObject(with: id) as? T
        } catch {
            print(error)
        }
        return nil
    }
    
    func getAll<T: NSManagedObject>() -> [T] {
        do {
            let fetchRequest = NSFetchRequest<T>(entityName: "\(T.self)")
            return try self.moc.fetch(fetchRequest)
        } catch {
            print(error)
            return []
        }
    }
    
    func save() {
        do {
            try moc.save()
        } catch {
            print(error)
        }
    }
}

