//
//  Data.swift
//  DataBaseSQLite
//
//  Created by Артем on 4/8/19.
//  Copyright © 2019 Артем. All rights reserved.
//

import Foundation

enum menuButtons: Int {
    case createDB
    case removeDB
    case listTable
    case createTable
    case insertTable
    case updateTable
    case deleteValues
    case packTable
    case selectTable
    case selectAny
}

struct MyData {
    
    static var fm = FileManager.default
    static var url: URL?
    static var nameDB = "DataBase_From_XCode_Project.db"
    static var db: OpaquePointer?
    static let createMyTable = "MyTableFromXCodeGuard"
    
}
