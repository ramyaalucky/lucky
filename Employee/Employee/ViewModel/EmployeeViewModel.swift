//
//  EmployeeViewModel.swift
//  Employee
//
//  Created by ramya on 09/01/23.
//

import Foundation
class EmployeeViewModel {
    var departments = [Department]()
    var employees = [Employee]()
    var employeeTableDatas = [EmployeeTableModel]()
    var selectedDepartment : Department?
    var dbHandler:DatabaseHandler?
    
    // fetch datas
    func loadEmployeeDatas () {
        if let data = dbHandler?.loadDatasFromLocal() {
            employeeTableDatas = data
        }
    }
    func loadDepartment () {
        departments.append(Department(id: 1, name: "iOS"))
        departments.append(Department(id: 2, name: "Android"))
        departments.append(Department(id: 3, name: "Web"))
    }
    
    // Add datas
    func addSelectedDepartment (department:Department) {
        employeeTableDatas.append(EmployeeTableModel(department: department, data: nil))
    }
    func addEmployee (department:Department,employee:Employee){
        employeeTableDatas = employeeTableDatas.map({
            if $0.department?.id == department.id {
                var data = $0
                if  data.data == nil{
                    var employeeDatas = [Employee]()
                    employeeDatas.append(employee)
                    data.data = employeeDatas
                } else {
                    data.data?.append(employee)
                }
                return data
            }
            return $0
        })
        dbHandler?.savedatasToLocal(datas: employeeTableDatas)
    }
    
    // Update Datas
    func updateEmployee (at indexPath:IndexPath,employee:Employee,value:Bool) {
        var data = employee
        data.status = value
        employeeTableDatas[indexPath.section].data?[indexPath.row] = data
        dbHandler?.savedatasToLocal(datas: employeeTableDatas)
    }
    
    // Validate Datas
    func isEmployeeExist (employees:[Employee]?,name:String) -> Bool {
        if employees?.filter( {$0.name == name}).count ?? 0 > 0 {
            print("Already added")
            return true
        }
        return false
    }
    func isDepartmentAlreadyExist (department:Department) -> Bool {
        if employeeTableDatas.filter({$0.department?.id == department.id}).count > 0 {
            return true
        }
        return false
    }
    
    // Remove datas
    func removeEmployee (at indexPath:IndexPath) {
        employeeTableDatas[indexPath.section].data?.remove(at: indexPath.row)
        dbHandler?.savedatasToLocal(datas: employeeTableDatas)
    }
   
   
}

