//
//  DishModel.swift
//  KurashiruDemoApp
//
//  Created by TakanoYuki on 2017/08/19.
//  Copyright © 2017年 TakanoYuki. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class DishModel {
    var id: String = ""
    var type: String = ""
    var title: String = ""
    var thumbnailUrl: String = ""
    var isFavorite = false
    var registerFavoriteDate: Date?
    
    init() {}
    
    init(data: JSON) {
        parseJsonData(data)
    }
    
    private func parseJsonData(_ data: JSON) {
        if let id = data["id"].string {
            self.id = id
        }
        
        if let type = data["type"].string {
            self.type = type
        }
        
        if let attribute = data["attributes"].dictionary {
            if let title = attribute["title"]?.string {
                self.title = title
            }
            
            if let thumbnailUrl = attribute["thumbnail-square-url"]?.string {
                self.thumbnailUrl = thumbnailUrl
            }
        }
    }
    
    func toRLMDishModel() -> RLMDishModel {
        let rlm = RLMDishModel()
        rlm.id = id
        rlm.type = type
        rlm.title = title
        rlm.thumbnailUrl = thumbnailUrl
        rlm.isFavorite = isFavorite
        rlm.registerFavoriteDate = registerFavoriteDate
        return rlm
    }
}
