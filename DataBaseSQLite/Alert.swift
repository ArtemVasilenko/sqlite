//
//  Alert.swift
//  DataBaseSQLite
//
//  Created by Артем on 4/10/19.
//  Copyright © 2019 Артем. All rights reserved.
//

import UIKit

class Alert  {
    
    static var myAlert = Alert()

    
    func insertFromAlert(inVC: UIViewController) -> String {
        var name = String()
        var myName = String()
        var result: String?
        
        let alert = UIAlertController(title: "Input data", message: "data", preferredStyle: .alert)
        alert.addTextField()
        alert.addTextField()
        alert.textFields![0].placeholder = "input name table"
        alert.textFields![1].placeholder = "insert new name"
        let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
            let answer = alert.textFields![0]
            myName = alert.textFields![1].text ?? ""
            name = answer.text ?? ""
          result = Engine.myEngine.insertTableClass(nameTable: name, name: myName)
            
//            Engine.myEngine.createDBEngine(name: name) //<--- сингл Тон
        }
        alert.addAction(submitAction)
        inVC.present(alert, animated: true, completion: nil)
        
        return "in table \(name) insert \(myName) "
        
    }
    
}
