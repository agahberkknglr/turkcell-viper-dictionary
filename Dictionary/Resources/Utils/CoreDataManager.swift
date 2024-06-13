//
//  CoreDataManager.swift
//  Dictionary
//
//  Created by Agah Berkin Güler on 13.06.2024.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveWord(recent: String) {
        let fetchRequest: NSFetchRequest<SearchHistory> = SearchHistory.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "recent == %@", recent)

        do {
            let results = try context.fetch(fetchRequest)
            if results.isEmpty {
                let searchHistory = SearchHistory(context: context)
                searchHistory.recent = recent
                saveContext()
            } else {
                print("Word already exists in search history.")
            }
        } catch {
            print("Failed to fetch search history: \(error)")
        }
    }
    
    func fetchSearchHistory() -> [String] {
        let fetchRequest: NSFetchRequest<SearchHistory> = SearchHistory.fetchRequest()
        do {
            let history = try context.fetch(fetchRequest)
            return history.compactMap { history in
                if let recentWord = history.recent {
                    return recentWord
                }
                return nil
            }
        } catch {
            print("Failed to fetch favorite games: \(error)")
            return []
        }
    }
}
