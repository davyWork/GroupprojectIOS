//  PROGRAMMER: Davy Mbaku Ngoma, Alexandra Daglio, Rebecca Dupuis

//  PANTHERID: 6043597, 2254610, 6056552

//  CLASS: COP 465501 online

//  INSTRUCTOR: Steve Luis ECS 282

//  ASSIGNMENT: Group Project- Deliverable 2

//  DUE: Saturday 08/01/2020
//
//  showImageOnlyModel.swift
//  Groupject
//
//  Created by davy ngoma mbaku on 7/31/20.
//  Copyright © 2020 davyngoma. All rights reserved.
//

import Foundation
import UIKit

//view model for show image only
// UIKit because the view MOdel is a representation of the view
class showImageOnlyModel {
    var titleValue: String?
    var image: UIImage?
    var timerLabel: Double?
    
    init(value: Model.Announcement) {
        self.titleValue = value.title
        self.image  = value.image
        self.timerLabel = value.timeLimit
    }
    
    //getTitleValue
    func getTitleValue() -> String{
        return titleValue ?? ""
    }
    
    //getimage
    func getimage() -> UIImage {
        return image ?? UIImage(named: "600px-No_image_available.svg") ?? UIImage()
    }
    
    func getTimer() -> Double {
        return timerLabel ?? 1.0
    }
}

