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
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        fetchRequest.fetchLimit = 5

        do {
            let lastFiveItems = try context.fetch(fetchRequest)
            let lastFiveWords = lastFiveItems.compactMap { $0.recent }
            if lastFiveWords.contains(recent) {
                print("Word already exists in the last 5 items of search history.")
                return
            }
            
            let searchHistory = SearchHistory(context: context)
            searchHistory.recent = recent
            searchHistory.timestamp = Date()
            saveContext()
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
