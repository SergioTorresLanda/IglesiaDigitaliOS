//
//  RealManagerRS.swift
//  EncuentroCatolicoNews
//
//  Created by Billy on 21/11/21.
//

import Foundation
import RealmSwift
/*
 public class RealmManager {
     public static let realm = try? Realm()
     
     public static func addToDataBase<T: Object>(_ object: [T]) {
         guard let realm = realm else { return }
         try? realm.write {
             realm.add(object, update: .modified)
         }
     }
     
 */


public class RealManagerRS{
    
    public static let realm = try? Realm()
    
    public static func addRSToDataBase<T: Object>(_ object: T){
        guard let realm = realm else { return }
        try? realm.write {
            realm.add(object, update: .modified)
        }
    }
    
    
    public static func rsFetcData<T: Object>(objec: T.Type) -> [T]?{
        guard let realm = realm else {return nil}
        let rsTimeLine = realm.objects(objec.self)
        return Array(rsTimeLine)
    }
}
