//
//  DepartmentTableCell.swift
//  Employee
//
//  Created by ramya on 09/01/23.
//

import UIKit

class DepartmentHeaderView: UIView{
    
    var viewModel = EmployeeViewModel()
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    var addTapped : (() -> ()) = {}
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
  
    @IBAction func addTapped(_ sender: Any) {
        addTapped()
    }
}
