//
//  DishModelManager.swift
//  KurashiruDemoApp
//
//  Created by TakanoYuki on 2017/08/19.
//  Copyright © 2017年 TakanoYuki. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

final class DishModelManager {
    private init() {}
    static let shared = DishModelManager()
    let requestEndpoint = "https://s3-ap-northeast-1.amazonaws.com/data.kurashiru.com/videos_sample.json"
    let dbFetchLimit = 20
    
    func getServerDishModels(loadComplete:@escaping (_ dishModels: [DishModel]) -> Void) {
        APIClient.request(requestEndpoint, loadComplete: {
            dishModels in
            self.insertServerDishModels(dishModels)
            loadComplete(dishModels)
        })
    }
    
    func insertServerDishModels(_ dishModels: [DishModel]) {
        let realm = try! Realm()
        var savedModel = [RLMDishModel]()
        for model in dishModels {
            savedModel.append(model.toRLMDishModel())
        }
        try! realm.write {
            realm.add(savedModel, update: true)
        }
    }
    
    func registerFavoriteItem(_ model: DishModel, flg: Bool) {
        model.isFavorite = flg
        dispatch_async_global {
            let realm = try! Realm()
            let rlmModel = realm.object(ofType: RLMDishModel.self, forPrimaryKey: model.id as Any)
            try! realm.write {
                rlmModel?.isFavorite = model.isFavorite
                rlmModel?.registerFavoriteDate = Date()
            }
        }
    }
    
    func getDBDishModels() -> [DishModel] {
        let predicate = NSPredicate(format: "isFavorite = true")
        let realm = try! Realm()
        let results = realm.objects(RLMDishModel.self).filter(predicate).sorted(byKeyPath: "registerFavoriteDate", ascending: false)
        var dishModels = [DishModel]()
        for rlmModel in results {
            dishModels.append(rlmModel.toDishModel())
        }
        return dishModels
    }
}

extension DishModelManager {
    fileprivate func dispatch_async_global(_ block: @escaping () -> ()) {
        DispatchQueue.global(qos: .default).async(execute: block)
    }
}
