//  PROGRAMMER: Davy Mbaku Ngoma, Alexandra Daglio, Rebecca Dupuis

//  PANTHERID: 6043597, 2254610, 6056552

//  CLASS: COP 465501 online

//  INSTRUCTOR: Steve Luis ECS 282

//  ASSIGNMENT: Group Project- Deliverable 2

//  DUE: Saturday 08/01/2020
//
//code : https://www.youtube.com/channel/UCEqBqOKq5caVU6iAuOhRboQ?view_as=subscriber
import Foundation


let date = Date()
let calendar = Calendar.current

let day = calendar.component(.day , from: date)
var weekday = calendar.component(.weekday, from: date) - 1
var month = calendar.component(.month, from: date) - 1
var year = calendar.component(.year, from: date)
 
