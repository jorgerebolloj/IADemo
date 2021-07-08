//
//  RealmApi.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 07/07/21.
//

import Foundation
import RealmSwift

protocol RealmSubscriber {
    func createRealmEntity() -> Object
}

class RealmApi {
    let realm = try! Realm()
    
    // Write an entity in Realm DB (Setted as default)
    
    func writeEntity(_ entity: Object) {
        do {
            try realm.write {
                realm.add(entity, update: .all)
            }
        } catch {
            print(error)
        }
    }
    
    // Write a collection of entities in Realm DB (Setted as default)
    
    func writeEntityCollection(_ entity: [Object]) {
        try! realm.write {
            realm.add(entity, update: .all)
        }
    }
    
    // Deletes an entity from Realm DB (Setted as default)
    
    func deleteEntity(_ entity: Object) {
        try! realm.write({
            realm.delete(entity)
        })
    }
    
    // Deletes a collection of entities from Realm DB (Setted as default)
    
    func deleteEntityCollection(_ entity: [Object]) {
        try! realm.write({
            realm.delete(entity)
        })
    }
    
    // Delete all entities from Realm DB (Setted as default)
    
    func deleteAll() {
        try! realm.write({
            realm.deleteAll()
        })
    }
    
    // Set Realm DB (As default)
    
    func getDefaultConfig(_ username: String) {
        setDefaultRealm(username)
    }
    
    // Clean Realm DB (As default)
    
    func getCleanEmptyRealmFiles() {
        cleanEmptyRealmFiles()
    }
    
    /**
     Method to select all objects of a type from Realm DB
     
     - Parameters:
     
         - className: Name of the class for which a "select * from"
         - predicate: Query to be executed within the database, if it is null, no filter is executed
         
         
         Returns: Returns an array of the type passed by the Type parameter
     */
    
    func select(className type: AnyClass, predicate query: NSPredicate?) -> [Object] {
        let tipoClase = type as? Object.Type
        let resultadosSelect = query != nil ? realm.objects(tipoClase!).filter(query!) : realm.objects(tipoClase!)
        let results = Array(resultadosSelect)
        
        return results
    }
}

@objcMembers
class RLMString: Object {
    dynamic var value: String = ""
    dynamic var id: String = ""
    
    static func create(value: String) -> RLMString {
        let string = RLMString()
        string.value = value
        string.id = ProcessInfo.processInfo.globallyUniqueString
        return string
    }
    
    internal override class func primaryKey() -> String {
        return "id"
    }
}

func == (lhs: RLMString, rhs: RLMString) -> Bool {
    return lhs.value == rhs.value
}
