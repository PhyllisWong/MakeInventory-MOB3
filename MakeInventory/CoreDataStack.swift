//
//  CoreDataStack.swift
//  MakeInventory
//
//  Created by Eliel A. Gordon on 11/12/17.
//  Copyright © 2017 Eliel Gordon. All rights reserved.
//

import Foundation
import CoreData

// public means visibility modifier, final means you can't subclass
public final class CoreDataStack {
    
    
    // static means you can only have a single instance of it
    // the whole app will use the single instance of the database
    static let instance = CoreDataStack()
    
    
    // lazy means its initialized when it is accessed, not when the variable is created
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(
            name: "MakeInventory"
        )
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    // for fetching the data - main queue
    lazy var viewContext: NSManagedObjectContext = {
        let viewContext = persistentContainer.viewContext
        return viewContext
    }()
    
    
    // used for everything else - background queue
    lazy var privateContext: NSManagedObjectContext = {
        return persistentContainer.newBackgroundContext()
    }()
    
    
    // saves all the changes that the managedObject tracks
    func saveTo(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
