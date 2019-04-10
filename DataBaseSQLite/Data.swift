//
//  Data.swift
//  DataBaseSQLite
//
//  Created by Артем on 4/8/19.
//  Copyright © 2019 Артем. All rights reserved.
//

import Foundation



struct MyData {
    
    static var fm = FileManager.default
    static var url: URL?
    static var nameDB = "DataBase_From_XCode_Project.db"
    static var db: OpaquePointer?
    static let createMyTable = "MyTableFromXCodeGuard"
    static var arrTable = [String]()
    
}
