//
//  RLMDishModel.swift
//  KurashiruDemoApp
//
//  Created by TakanoYuki on 2017/08/19.
//  Copyright © 2017年 TakanoYuki. All rights reserved.
//

import Foundation
import RealmSwift

class RLMDishModel: Object {
    dynamic var id: String = ""
    dynamic var type: String = ""
    dynamic var title: String = ""
    dynamic var thumbnailUrl: String = ""
    dynamic var isFavorite = false
    dynamic var registerFavoriteDate: Date?
    
    override class func primaryKey() -> String {
        return "id"
    }
}

extension RLMDishModel {
    func toDishModel() -> DishModel {
        let dishModel = DishModel()
        dishModel.id = id
        dishModel.type = type
        dishModel.title = title
        dishModel.thumbnailUrl = thumbnailUrl
        dishModel.isFavorite = isFavorite
        dishModel.registerFavoriteDate = registerFavoriteDate
        return dishModel
    }
}
