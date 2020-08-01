//  PROGRAMMER: Davy Mbaku Ngoma, Alexandra Daglio, Rebecca Dupuis

//  PANTHERID: 6043597, 2254610, 6056552

//  CLASS: COP 465501 online

//  INSTRUCTOR: Steve Luis ECS 282

//  ASSIGNMENT: Group Project- Deliverable 2

//  DUE: Saturday 08/01/2020
//
//  DetailViewMOdel.swift
//  Groupject
//
//  Created by davy ngoma mbaku on 7/26/20.
//  Copyright © 2020 davyngoma. All rights reserved.
//

import Foundation
import UIKit

class DetailViewModel {
    var timeLimit: Double?
    var field1: String?
    var filed2: String?
    var filed3: String?
    var filed5: String?
    var filed4: String?
    var index: Int?
    var image: UIImage?
    var title: String?
    
    init(value: Model.Announcement, indexPath: Int) {
        self.timeLimit = value.timeLimit
        self.field1  = value.description
        self.filed2  = value.date
        self.filed3  = value.hours
        self.filed5  = value.location
        self.filed4  = value.contactPerson
        self.index = indexPath
        self.image = value.image
        self.title = value.title
    }
}
