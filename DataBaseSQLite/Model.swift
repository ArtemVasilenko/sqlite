import SQLite3
import Foundation

protocol DB {
    func removeDB(url: URL, fm: FileManager)
    func createURL(nameDB: String, fm: FileManager) -> URL
    func createDataBase(url: URL) -> OpaquePointer?
    func createTableInDB(db: OpaquePointer, newTable: String)
    func insertInTable(db: OpaquePointer, inTable: String, name: String)
    func updateTableWithGuard(db: OpaquePointer, inTable: String, name: String, id: String)
    func selectFromTable(db:OpaquePointer,inTable:String,name:String, afterWhere: String) -> [String]
    func deleteFromTable(db:OpaquePointer,inTable:String, id: String)
    func dropTable(db:OpaquePointer,inTable:String)
    func getListTable(db:OpaquePointer) -> [String]
    func closeDB(db:OpaquePointer)
    func anySelect(db:OpaquePointer,query:String) -> [String]
}


extension DB {
    
    func anySelect(db:OpaquePointer,query:String) -> [String] {
        var values = [String]()
        var str : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, query, -1, &str, nil)==SQLITE_OK{
            print("AnyQuery \(query) is Done")
        } else {
            print("AnyQuery \(query) is incorrect")
        }
        
        while (sqlite3_step(str)) == SQLITE_ROW {
            var value: String = ""
            
            for i in 0...sqlite3_column_count(str) {
                let name = String(cString: sqlite3_column_text(str, i))
                value += " " + name
            }
            values.append(value)
        }
        
        return values
    }
    
    func getListTable(db:OpaquePointer) -> [String]{
        var str : OpaquePointer? = nil
        var values = [String]()
        let query:String = " select name from sqlite+master where type = 'table' and name,. 'sqlite_sequence'"
        
        if sqlite3_prepare_v2(db, query, -1, &str, nil)==SQLITE_OK{
            print("query \(query) is Done")
        } else {
            print("query \(query) is incorrect")
        }
        while (sqlite3_step(str)) == SQLITE_ROW {
            let name = String(cString: sqlite3_column_text(str, 1))
            values.append(name)
        }
        return values
    }
    
    func closeDB(db:OpaquePointer){
        sqlite3_close(db)
    }
    
    func dropTable(db:OpaquePointer, inTable:String){
        var del : OpaquePointer? = nil
        let query: String = "DROP TABLE  \(inTable)"
        
        print(query)
        
        guard sqlite3_prepare_v2(db, query, -1, &del, nil) == SQLITE_OK else {
            print("error prepare drop")
            return
        }
        guard sqlite3_step(del) == SQLITE_DONE  else {
            print("error drop")
            return
        }
        sqlite3_finalize(del)
    }
    
    func deleteFromTable(db:OpaquePointer,inTable:String, id: String) {
        var del : OpaquePointer? = nil
        let query:String = "DELETE FROM \(inTable) WHERE ID =  \(id) "
        guard sqlite3_prepare_v2(db, query, -1, &del, nil)==SQLITE_OK else {
            print("error prepare deleting")
            return
        }
        guard sqlite3_step(del) == SQLITE_DONE  else {
            print("error deleting")
            return
        }
        sqlite3_finalize(del)
        
    }
    
    func selectFromTable(db:OpaquePointer,inTable:String,name:String, afterWhere: String) -> [String]{
        
        var str : OpaquePointer? = nil
        var values = [String]()
        var query:String = "SELECT \(name) FROM \(inTable) "
        
        if afterWhere != "" {
            query += "WHERE \(afterWhere)"
        }
        
        if sqlite3_prepare_v2(db, query, -1, &str, nil)==SQLITE_OK{
            print("query \(query) is Done")
        } else {
            print("query \(query) is incorrect")
        }
        while (sqlite3_step(str)) == SQLITE_ROW {
            let id = sqlite3_column_int(str, 0)
            let name = String(cString: sqlite3_column_text(str, 1))
            values.append(String(id) + " " + name)
        }
        
        return values
    }
    
    func createURL(nameDB: String, fm: FileManager) -> URL {
        var url = URL(fileURLWithPath: "")
        do {
            url = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(nameDB)
        } catch {
            print(error)
        }
        return url
    }
    
    func removeDB(url: URL, fm: FileManager) {
        do {
            try fm.removeItem(at: url)
        } catch {
            print("error delete DB")
        }
        
    }
    
    func createDataBase(url: URL) -> OpaquePointer? {
        var db: OpaquePointer? = nil
        
        guard sqlite3_open(url.path, &db) == SQLITE_OK else {
            print("error creating bd \(Error.self)")
            return nil }
        print("create done \(url.path)")
        return db
    }
    
    func createTableInDB(db: OpaquePointer, newTable: String) {
        var table: OpaquePointer? = nil
        let query = """
        CREATE TABLE \(newTable) (
        "ID"    INTEGER PRIMARY KEY AUTOINCREMENT,
        "Name"    TEXT NOT NULL UNIQUE
        );
        """
        
        guard sqlite3_prepare_v2(db, query, -1, &table, nil) == SQLITE_OK else {
            print("prepare error")
            return }
        guard sqlite3_step(table) == SQLITE_DONE else {
            print("table query error")
            return
        }
        print("table query")
        
        sqlite3_finalize(table) //закрытие таблицы после изменений (транзакции)
    }
    
    func insertInTable(db: OpaquePointer, inTable: String, name: String) {
        var insert: OpaquePointer? = nil
        let insertString = """
        INSERT INTO \(inTable) (name) VALUES ('\(name)');
        """
        guard sqlite3_prepare_v2(db, insertString, -1, &insert, nil) == SQLITE_OK,
            sqlite3_step(insert) == SQLITE_DONE else {
                print("error insert in table")
                return
        }
        print("insert in table done")
        sqlite3_finalize(insert)
    }
    
    func updateTableWithGuard(db: OpaquePointer, inTable: String, name: String, id: String) {
        var update: OpaquePointer? = nil
        let updateString = """
        UPDATE \(inTable) SET name = '\(name)' WHERE iD = \(id)
        """
        guard sqlite3_prepare_v2(db, updateString, -1, &update, nil) == SQLITE_OK,
            sqlite3_step(update) == SQLITE_DONE else {
                print("error create update")
                return
        }
        print("update whith guard done")
    }
}
