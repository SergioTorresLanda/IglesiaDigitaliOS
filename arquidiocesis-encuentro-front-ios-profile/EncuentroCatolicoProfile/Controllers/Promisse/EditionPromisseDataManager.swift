//
//  EditionPromisseDataManager.swift
//  EncuentroCatolicoProfile
//
//  Created by Jorge Cruz on 23/03/21.
//

import UIKit
import CoreData

open class EditionPromisseDataManager: NSObject {
    
    public static let shareInstance = EditionPromisseDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let messageKitBundle = Bundle(identifier: "mx.arquidiocesis.EncuentroCatolicoProfile")
        let modelURL = messageKitBundle!.url(forResource: "EncuentroCatolicoProfile", withExtension: "momd")
        let managetObjModel = NSManagedObjectModel(contentsOf: modelURL!)
        let container = NSPersistentContainer(name: "EncuentroCatolicoProfile",managedObjectModel: managetObjModel!)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    private func saveContext () {
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
    
    func addNewProfile(profileModel: ProfileModel)->Void{
        let managedContext = self.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Profile", in: managedContext)!
        let profile = NSManagedObject(entity: entity, insertInto: managedContext)
        let exits = findByEmail(profileID: profileModel.email ?? "").count
        if(exits == 0){
            profile.setValue(profileModel.email, forKey: "email")
            profile.setValue(profileModel.image, forKey: "avatar")
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }else{
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Profile")
            let predicate = NSPredicate(format: "email == %@", profileModel.email ?? "")
            fetchRequest.predicate = predicate
            do{
                let result = try managedContext.fetch(fetchRequest) as? [Profile] ?? []
                if result.count != 0 {
                    let profileMO = result[0]
                    profileMO.avatar = profileModel.image //?? ""
                    do{
                        try managedContext.save()
                    }catch let error as NSError {
                        print("Error al modificar: \(error)")
                    }
                }
            }catch let error as NSError {
                print("Error al modificar: \(error)")
            }
        }
    }
    
    func addNewPromise(promisse: PromiseModel)->Void{
        
        let managedContext = self.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Promisse", in: managedContext)!
        let promise = NSManagedObject(entity: entity, insertInto: managedContext)
        
        promise.setValue(promisse.dateStarted, forKey: "dateStarted")
        promise.setValue(promisse.flag, forKey: "flag")
        promise.setValue(promisse.periodInterval, forKey: "periodInterval")
        promise.setValue(promisse.promisseTo, forKey: "promisseTo")
        promise.setValue(promisse.promisseToIdentifier, forKey: "promisseToIdentifier")
        promise.setValue(promisse.promisseDescription, forKey: "promisseDescription")
        promise.setValue(promisse.profileID, forKey: "profileID")
        promise.setValue(promisse.dateEnd, forKey: "dateEnd")
        promise.setValue(promisse.imageSaint, forKey: "imageSaint")
        
        do {
            try managedContext.save()
            NotificationCenter.default.post(name: Notification.Name("reloadData"), object: nil)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    public func findByEmail(profileID:String)->[ProfileModel]{
        let managedContext = self.persistentContainer.viewContext
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        request.predicate = NSPredicate(format: "email == %@", profileID)
        var result = [ProfileModel]()
        do {
            let requestDictionary = try managedContext.fetch(request)
            let resultByDB = requestDictionary as! [Profile]
            result = resultByDB.compactMap({ (elements) -> ProfileModel in
                var profileModel = ProfileModel()
                profileModel.email = elements.email
                profileModel.image = elements.avatar
                return profileModel
            })
            return result.reversed()
        } catch {
            return [ProfileModel]()
        }
    }
    
    func allPromisse(profileID:String)->[PromiseModel]{
        let managedContext = self.persistentContainer.viewContext
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Promisse")
        request.predicate = NSPredicate(format: "profileID == %@", profileID)
        var result = [PromiseModel]()
        do {
            let requestDictionary = try managedContext.fetch(request)
            let resultByDB = requestDictionary as! [Promisse]
            result = resultByDB.compactMap({ (elements) -> PromiseModel in
                var promiseModel = PromiseModel()
                promiseModel.dateStarted = elements.dateStarted
                promiseModel.dateEnd = elements.dateEnd
                promiseModel.flag = elements.flag
                promiseModel.periodInterval = elements.periodInterval
                promiseModel.profileID = elements.profileID
                promiseModel.promisseDescription = elements.promisseDescription
                promiseModel.promisseTo = elements.promisseTo ?? ""
                promiseModel.promisseToIdentifier = Int(elements.promisseToIdentifier)
                promiseModel.imageSaint = elements.imageSaint
                return promiseModel
            })
            return result.reversed()
        } catch {
            return [PromiseModel]()
        }
    }
}
