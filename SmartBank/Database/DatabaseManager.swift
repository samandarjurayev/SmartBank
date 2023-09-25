//
//  DatabaseManager.swift
//  SmartBank
//
//  Created by Samandar Jurayev on 25/09/23.
//

import Foundation
import RealmSwift

let schemaVersion: UInt64 = 1

final class DatabaseManager {

    // MARK: - Properties
    static let shared = DatabaseManager()
    
    lazy var realm: Realm? = {
        if let file = Realm.Configuration.defaultConfiguration.fileURL {
            let realmConfig = Realm.Configuration(fileURL: file, schemaVersion: schemaVersion, migrationBlock: { (migration, oldSchemaVersion) in

            }, deleteRealmIfMigrationNeeded: false, objectTypes: nil)

            Realm.Configuration.defaultConfiguration = realmConfig
        }

        do {
            let realm = try Realm()
            print("SECCESS START REALM")
            print("REALM Schema Version: \(realm.configuration.schemaVersion)")

            return realm

        } catch let error {
            print("FAILED START REALM")
            print("REALM ERROR: \(error)")
            assertionFailure()
        }

        return nil
    }()

    // MARK: - Private Init
    private init() {

    }

    // MARK: - Public
    func insertToRealm(object: Object) {
        if let realm = self.realm {
            do {
                try realm.write {
                    realm.add(object)
                }
            } catch let error {
                debugPrint("insertToRealm \(error)")
            }
        }
    }

    func deleteFromRealm<Element: Object>(_ model: Element.Type) {
        if let realm = self.realm {
            do {
                let results = DatabaseManager.shared.realm?.objects(model)

                try realm.write {
                    if let object = results {
                        realm.delete(object)
                    }
                }
            } catch let error {
                debugPrint("deleteFromRealm \(error)")
            }
        }
    }
}
