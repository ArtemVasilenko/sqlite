
import Foundation

class Engine: DB {
    
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
    
}
