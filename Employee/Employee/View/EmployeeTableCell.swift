//
//  EmployeeTableCell.swift
//  Employee
//
//  Created by ramya on 09/01/23.
//

import UIKit

class EmployeeTableCell: UITableViewCell {
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var employeeSwitch: UISwitch!
    var removeTapped : (() -> ()) = {}
    var switchTapped : ((Bool) -> ()) = {_ in }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func removeTapped(_ sender: Any) {
        removeTapped()
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        switchTapped(sender.isOn)
    }
}
