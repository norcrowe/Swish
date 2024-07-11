import Foundation
import RealmSwift

class Migrator {
    init() {
        updateSchema()
    }
    
    func updateSchema() {
        let config = Realm.Configuration(schemaVersion: 1) { migration, oldSchemaVersion in
            
        }
        
        Realm.Configuration.defaultConfiguration = config
        
        let _ = try! Realm()
    }
}

