//
//  AppConfig.swift
//  KurashiruDemoApp
//
//  Created by TakanoYuki on 2017/08/20.
//  Copyright © 2017年 TakanoYuki. All rights reserved.
//

import Foundation

enum BuildType {
    case debug
    case release
}

class BuildConfig {
    class func type() -> BuildType {
        #if DEBUG
            return .debug
        #else
            return .release
        #endif
    }    
}
