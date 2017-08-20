//
//  RealmUtils.swift
//  KurashiruDemoApp
//
//  Created by TakanoYuki on 2017/08/20.
//  Copyright © 2017年 TakanoYuki. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmUtils {}

extension RealmUtils {
    static func migrationRealm() {
        var config = Realm.Configuration(
            schemaVersion: 0,
            migrationBlock: { migration, oldSchemaVersion in
                
        })
        config.fileURL = URL(string: getRealmPath())
        Realm.Configuration.defaultConfiguration = config
        
    }
    
    static func getRealmPath() -> String {
        let documentDirectory: NSString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        switch(BuildConfig.type()) {
        case .debug:
            return documentDirectory.appendingPathComponent("debug.realm")
        case .release:
            return Realm.Configuration.defaultConfiguration.fileURL!.absoluteString
        default:
            return documentDirectory.appendingPathComponent("noBuildConfig.realm")
        }
    }
}

    
    

