//
//  RealmConfig.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 07/07/21.
//

import Foundation
import RealmSwift

func setDefaultRealm(_ username: String) {
    var config = Realm.Configuration()
    
    // Use the default directory
    
    config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(username).realm")
    
    // Set this as the configuration used for the default Realm
    
    Realm.Configuration.defaultConfiguration = config
}

func cleanEmptyRealmFiles() {
    
    // Create a FileManager instance
    
    let fileManager = FileManager.default
    
    // Get the document directory url
    
    let documentsUrl =  fileManager.urls(for: .documentDirectory, in: .userDomainMask)
    
    do {
        let realm = try! Realm()
        let initialRealmConfig = realm.configuration
        
        // Get the directory contents urls (including subfolders urls)
        
        let directoryContents = try FileManager.default.contentsOfDirectory( at: documentsUrl.first!, includingPropertiesForKeys: nil, options: [])
        
        // if you want to filter the directory contents you can do like this:
        
        let realmFiles = directoryContents.filter{ $0.pathExtension == "realm" }
        let realmFileNames = realmFiles.flatMap({$0.deletingPathExtension().lastPathComponent}).map(String.init)
        
        for realmFileName in realmFileNames {
            setDefaultRealm(realmFileName)
            let realm = try! Realm()
            if realm.objects(LoginRLM.self).isEmpty {
                let files = ["\(realmFileName).realm", "\(realmFileName).realm.lock", "\(realmFileName).realm.management"]
                
                // Delete empty realm files
                
                do {
                    for file in files {
                        if let filePath = documentsUrl.first?.appendingPathComponent(file).path {
                            try fileManager.removeItem(atPath: filePath)
                        }
                    }
                }
                catch let error as NSError {
                    print("Error al intentar borrar los archivos: \(error)")
                }
            }
        }
        
        // Set this as the configuration used for the default Realm
        
        Realm.Configuration.defaultConfiguration = initialRealmConfig
    } catch let error as NSError {
        print(error.localizedDescription)
    }
}

