//
//  ViewController.swift
//  Employee
//
//  Created by ramya on 09/01/23.
//

import UIKit

class ViewController: UIViewController {
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    var viewModel = EmployeeViewModel()
    let employeeCellIdentifier = "EmployeeTableCell"
    let departmentCellIdentifier = "DepartmentTableCell"

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadEmployeeDatas()
        viewModel.loadDepartment()
        tableView.register(UINib(nibName: employeeCellIdentifier, bundle: nil), forCellReuseIdentifier: employeeCellIdentifier)
        // Do any additional setup after loading the view.
    }

    @IBAction func selectDepartmentTapped(_ sender: Any) {
       setupPickerView()
       setInitialValueToPicker()
    }
    func addEmployeeAlertView (data:EmployeeTableModel) {
        let alertController = UIAlertController(title: "Add New Employee", message: "", preferredStyle: .alert)
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Enter Employee Name"
            }
            let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
                let firstTextField = alertController.textFields![0] as UITextField
                if let name = firstTextField.text {
                    if self.viewModel.isEmployeeExist(employees: data.data, name: name) {
                        print("Already added")
                        self.showAlert(title: "Employee Already Exist", message: "Please enter new name", actionTitle: "Okay")
                    } else {
                        if let department = data.department {
                            self.viewModel.addEmployee(department: department, employee: Employee(name: name, departmentId: department.id, status: false))
                        self.tableView.reloadData()
                        }
                    }
                }
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
    }
    func showAlert(title:String,message:String,actionTitle:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {       
        let headerView = Bundle.main.loadNibNamed("DepartmentHeaderView", owner: self, options: nil)?.last as! DepartmentHeaderView
        let data = viewModel.employeeTableDatas[section]
        if  let department = viewModel.employeeTableDatas[section].department {
            headerView.titleLabel.text = department.name
        }
        headerView.addTapped = {
            self.addEmployeeAlertView(data: data)
        }
        return headerView
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.employeeTableDatas.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.employeeTableDatas[section].data?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: employeeCellIdentifier, for: indexPath) as! EmployeeTableCell
        if let data = viewModel.employeeTableDatas[indexPath.section].data?[indexPath.row] {
            cell.titleLabel.text = data.name
            cell.removeTapped = {
                self.viewModel.removeEmployee(at: indexPath)
                self.tableView.reloadData()
            }
            cell.switchTapped = { value in
                self.viewModel.updateEmployee(at: indexPath, employee: data,value: value)
                self.tableView.reloadData()
            }
            cell.employeeSwitch.isOn = data.status
        }
        return cell
    }
}

extension ViewController : UIPickerViewDelegate,UIPickerViewDataSource {
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        if let department = viewModel.selectedDepartment {
            if viewModel.isDepartmentAlreadyExist(department: department) {
                showAlert(title: "Department Already Exist", message: "Please choose different department", actionTitle: "Okay")
            } else {
                viewModel.addSelectedDepartment(department: department)
                tableView.reloadData()
            }
        }
    }
    @objc func onCancelButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    func setInitialValueToPicker () {
        viewModel.selectedDepartment = viewModel.departments.first
    }
    func setupPickerView () {
           picker = UIPickerView.init()
           picker.delegate = self
           picker.dataSource = self
           picker.backgroundColor = UIColor.white
           picker.setValue(UIColor.black, forKey: "textColor")
           picker.autoresizingMask = .flexibleWidth
           picker.contentMode = .center
           picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
           self.view.addSubview(picker)
                   
           toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
           toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped)),UIBarButtonItem.init(title: "Cancel", style: .done, target: self, action: #selector(onCancelButtonTapped))]
           self.view.addSubview(toolBar)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.departments.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.departments[row].name
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.selectedDepartment = viewModel.departments[row]
    }
}
