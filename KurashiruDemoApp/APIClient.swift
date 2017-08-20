//
//  APIClient.swift
//  KurashiruDemoApp
//
//  Created by TakanoYuki on 2017/08/19.
//  Copyright © 2017年 TakanoYuki. All rights reserved.
//

import Alamofire
import SwiftyJSON

struct APIClient {}

extension APIClient {
    
    static func request(_ endpoint: String, loadComplete:@escaping ([DishModel]) -> Void) {
        Alamofire.request(endpoint, method: .get).responseJSON { response in
            var dishModels = [DishModel]()
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                guard let results = json["data"].array else {
                    return loadComplete(dishModels)
                }
                for row in results {
                    dishModels.append(DishModel(data: row))
                }
                return loadComplete(dishModels)
            case .failure(_):
                return loadComplete(dishModels)
            }
        }
    }
}
