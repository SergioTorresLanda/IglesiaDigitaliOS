//
//  RealmManager.swift
//  RedSocialFramework
//
//  Created by Miguel Angel Vicario Flores on 20/11/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import Foundation
import RealmSwift

public class RealmManager {
    public static let realm = try? Realm()
    
    public static func addToDataBase<T: Object>(_ object: [T]) {
        guard let realm = realm else { return }
        try? realm.write {
            realm.add(object, update: .modified)
        }
    }
    
    public static func clearDataBase() {
        guard let realm = realm else { return }
        try? realm.write {
            realm.delete(realm.objects(PublicationRealm.self))
            realm.delete(realm.objects(AreaRealm.self))
            realm.delete(realm.objects(AutorRealm.self))
            realm.delete(realm.objects(FeelingRealm.self))
            realm.delete(realm.objects(LocationRealm.self))
            realm.delete(realm.objects(MediaRealm.self))
            realm.delete(realm.objects(MyReactionRealm.self))
            realm.delete(realm.objects(GroupRealm.self))
            realm.delete(realm.objects(ReactionsRealm.self))
        }
    }
    
    public static func delete(id: Int) {
        guard let realm = realm else { return }
        let deletedObject = realm.objects(PublicationRealm.self).filter("id == \(id)")
        try? realm.write {
            realm.delete(deletedObject)
        }
    }
    
    public static func fetchDataFiltered<T: Object>(object: T.Type, filter: Int) -> [T]? {
        guard let realm = realm else { return nil }
        let results = realm.objects(object.self).filter("area.id == \(filter)").sorted(byKeyPath: "created", ascending: false)
        return Array(results)
    }
    
    public static func fetchDataSorted<T: Object>(object: T.Type) -> [T]? {
        guard let realm = realm else { return nil }
        let results = realm.objects(object.self).sorted(byKeyPath: "created", ascending: false)
        return Array(results)
    }
    
    public static func fetchData<T: Object>(object: T.Type) -> [T]? {
        guard let realm = realm else { return nil }
        let results = realm.objects(object.self)
        return Array(results)
    }
    
    public static func fetchDataForPK<T: Object>(object: T.Type, id: Int) -> T? {
        guard let realm = realm else { return nil }
        let result = realm.object(ofType: object, forPrimaryKey: id)
        return result
    }
}
