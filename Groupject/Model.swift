//
//  Model.swift
//  Groupject
//
//  Created by Alexandra Daglio on 7/22/20.
//  Copyright © 2020 davyngoma. All rights reserved.
//

import Foundation
import UIKit

class Model {

    struct Announcement {
        var title: String
        var description: String
        var data: NSDate
        var location: String
        var contactPerson: String
        var announcer: String
        var timeLimit: Double
        var category: String
    }
}
