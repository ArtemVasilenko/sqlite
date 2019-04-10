
import Foundation
import UIKit

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

class Engine: DB {
    
    static var myEngine = Engine()
    
    func choiceCommand(index: Int, text: String, vc: UIViewController) -> String {
        var message = String()
        
        guard let myIndex = menuButtons(rawValue: index) else { return "" }
        
        switch myIndex {
        case .createDB: message = createDB(path: text + ".db")
        case .removeDB: message = removeDBClass()
        case .listTable: ()
        case .createTable: message = createMyTable(queryCreateTable: text)
        case .insertTable: message = Alert.myAlert.insertFromAlert(inVC: vc)
        //        case .insertTable: message = "Error insert table"
        case .updateTable: ()
        case .deleteValues: ()
        case .packTable: ()
        case .selectTable: message = selectFromTableClass(nameTable: text)
        case .selectAny: ()
        }
        
        return message
    }
    
    func start() {
        MyData.url = createURL(nameDB: MyData.nameDB, fm: MyData.fm)
        removeDB(url: MyData.url!, fm: MyData.fm)
        MyData.db = createDataBase(url: MyData.url!)
        createTableInDB(db: MyData.db!, newTable: MyData.createMyTable)
        insertInTable(db: MyData.db!, inTable: "MyTableFromXCodeGuard", name: "Ignat")
        insertInTable(db: MyData.db!, inTable: "MyTableFromXCodeGuard", name: "Holodov")
        
        updateTableWithGuard(db: MyData.db!, inTable: "MyTableFromXCodeGuard", name: "Hi Holodov", id: "2")
        print(selectFromTable(db: MyData.db!, inTable: "MyTableFromXCodeGuard", name: "*", afterWhere: ""))
        deleteFromTable(db: MyData.db!, inTable: "MyTableFromXCodeGuard", id: "2")
        print(selectFromTable(db: MyData.db!, inTable: "MyTableFromXCodeGuard", name: "*", afterWhere: ""))
        //        dropTable(db: db!, inTable:"MyTableFromXCodeGuard" )
        print(anySelect(db: MyData.db!, query: "SELECT * FROM \(MyData.nameDB)"))
        closeDB(db: MyData.db!)
    }
    
    func createDB(path: String) -> String {
        MyData.nameDB = path
        let url = createURL(nameDB: path, fm: MyData.fm)
        MyData.url = url
        MyData.db = createDataBase(url: url)
        return "База \(path) успешно создана"
    }
    
    
    func createMyTable(queryCreateTable: String = MyData.createMyTable) -> String {
        createTableInDB(db: MyData.db!, newTable: queryCreateTable)
        
        return "Taблица \(queryCreateTable) успешно создана"
    }
    
    func removeDBClass() -> String {
        closeDB(db: MyData.db!)
        removeDB(url: MyData.url!, fm: MyData.fm)
        return "База \(MyData.nameDB) успешно удалена"
        
    }
    
    func insertTableClass(nameTable: String, name: String) -> String {
        insertInTable(db: MyData.db!, inTable: nameTable, name: name)
        return "in table \(nameTable) added \(name)"
    }
    
    func selectFromTableClass(nameTable: String) -> String {
        MyData.arrTable = selectFromTable(db: MyData.db!, inTable: nameTable, name: "*", afterWhere: "")
        
        var result = String()
        
        MyData.arrTable.forEach {
            result += $0 + "\n"
        }
        return "values from \(nameTable) = \(result)"
    }
    
}
