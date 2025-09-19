//
//  CoreDataManager.swift
//  Pointly
//
//  Created by Никита on 10.09.2025.
//

import Foundation
import CoreData

class CoreDataManager {
    public static let shared = CoreDataManager()
    
    let cantainer: NSPersistentContainer
    var context: NSManagedObjectContext { cantainer.viewContext }
    
    private init() {
        cantainer = NSPersistentContainer(name: "CoreData")
        cantainer.loadPersistentStores { _, error in
            if let error = error {
                
                if let url = self.cantainer.persistentStoreDescriptions.first?.url{
                    try? FileManager.default.removeItem(at: url)
                    self.cantainer.loadPersistentStores { _, error in
                        if let error = error{
                            fatalError("CoreData second error: \(error)")
                        }
                    }
                }
                
            }
        }
    }
    
    /*
     cantainer = NSPersistentContainer(name: "CoreData")
         cantainer.loadPersistentStores { _, error in
             if let error = error {
                 // 💡 просто удаляем старую базу
                 if let url = self.cantainer.persistentStoreDescriptions.first?.url {
                     try? FileManager.default.removeItem(at: url)
                     self.cantainer.loadPersistentStores { _, error in
                         if let error = error {
                             fatalError("CoreData second error: \(error)")
                         }
                     }
                 }
             }
         }
     */
    
    func save(){
        if context.hasChanges{
            try? context.save()
        }
    }
    
    //MARK: - CRUD
    
    //create
    func addItem(text: String, descr: String, time: String, isDone: Bool, day: String, priority: String, userId: String){
        let item = NoteModelLocal(context: CoreDataManager.shared.context)
        item.id = UUID().uuidString
        item.text = text
        item.descr = descr
        item.time = time
        item.isDone = isDone
        item.day = day
        item.priority = priority
        item.userId = userId
        
        CoreDataManager.shared.save()
    }
    
    //read
    func fetchData(for userId: String) -> [NoteModelLocal] {
        let request: NSFetchRequest<NoteModelLocal> = NoteModelLocal.fetchRequest()
        request.predicate = NSPredicate(format: "userId == %@", userId)
        return (try? CoreDataManager.shared.context.fetch(request)) ?? []
    }
    
    //update
    func updateItem(_ item: NoteModelLocal, newText: String){
        item.text = newText
        CoreDataManager.shared.save()
    }
    
    //delete
    func deleteItem(_ item: NoteModelLocal){
        CoreDataManager.shared.context.delete(item)
        CoreDataManager.shared.save()
    }
    
    //update is done
    func toggleDone(_ item: NoteModelLocal) {
        item.isDone.toggle()
        CoreDataManager.shared.save()
    }
}
