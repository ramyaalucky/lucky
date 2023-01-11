//
//  DatabaseHandler.swift
//  Employee
//
//  Created by ramya on 09/01/23.
//

import Foundation
class DatabaseHandler {
    func loadDatasFromLocal() -> [EmployeeTableModel]? {
        guard let data = UserDefaults.standard.data(forKey: "EmployeeTableDatas") else {
           // write your code as per your requirement
           return nil
         }
         guard let value = try? PropertyListDecoder().decode([EmployeeTableModel].self, from: data) else {
             return nil
         }
         return value
        
    }
    func savedatasToLocal(datas:[EmployeeTableModel]){
        guard let data = try? PropertyListEncoder().encode(datas) else {
            return
          }
          UserDefaults.standard.set(data, forKey: "EmployeeTableDatas")
    }
}
