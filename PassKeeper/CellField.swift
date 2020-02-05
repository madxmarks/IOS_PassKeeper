//
//  CellField.swift
//  Swift iOS Navigation and Tab Bar
//
//  Created by Marks on 21/09/2019.
//  Copyright © 2019 Marks. All rights reserved.
//

import UIKit

class CellField: UITableViewCell {
    
    @IBOutlet var textLab:UITextField?   // drag and drop the textfield to tableview cell.
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
