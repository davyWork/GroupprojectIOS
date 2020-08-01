//  PROGRAMMER: Davy Mbaku Ngoma, Alexandra Daglio, Rebecca Dupuis

//  PANTHERID: 6043597, 2254610, 6056552

//  CLASS: COP 465501 online

//  INSTRUCTOR: Steve Luis ECS 282

//  ASSIGNMENT: Group Project- Deliverable 2

//  DUE: Saturday 08/01/2020
//
//  CustomToolTableViewCell.swift
//  Groupject
//
//  Created by davy ngoma mbaku on 7/22/20.
//  Copyright © 2020 davyngoma. All rights reserved.
//

import UIKit

class CustomToolTableViewCell: UITableViewCell {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func bind(label1: String, label2: String) {
        self.label1.text = label1
        self.label2.text = label2
    }
}
