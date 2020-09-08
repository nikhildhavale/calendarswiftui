//
//  CalendarModel.swift
//  CalendarSwiftui
//
//  Created by Nikhil on 08/09/20.
//  Copyright © 2020 Nikhil. All rights reserved.
//

import Foundation
import UIKit
class CalendarModel:ObservableObject
{
    var navigationDirection = UIPageViewController.NavigationDirection.forward
    var date:Date
    {
        didSet{
            self.updateData()
        }
    }
    var numberOfDays = 0
    var firstDay = 0
    var day = 1
    //var dayArray = [DayItem]()
    var dayArry = [Int:[DayItem]]()
    var numberOfRows = 0
    var monthString:String!
    init(date:Date)
    {
        self.date = date
        self.updateData()
        
    }
    func updateData()
    {
        day = 1
        var dateComponents = Calendar.current.dateComponents([.month,.year], from: date)
        dateComponents.day = 1
        if let firstDate = Calendar.current.date(from: dateComponents)
        {
            let dayOfTheWeek = Calendar.current.component(.weekday, from: firstDate)
            firstDay = dayOfTheWeek - 1
        }
        let range = Calendar.current.range(of: .day, in: .month, for: date)
        numberOfDays = range?.count ?? 0
        let arrayString = ["S","M","T","W","T","F","S"]
        var dArray = [DayItem]()
        var indexValue = 0
        for index in arrayString.indices{
            dArray.append(DayItem(id: index, tileString: arrayString[index]))
        }
        dayArry[indexValue] = dArray
        var arrayDayString = Array.init(repeating: "  ", count: firstDay)
        for i in 1 ..< numberOfDays + 1
        {
            
            arrayDayString.append("\(i)")
        }
        dArray = [DayItem]()
        for index in arrayDayString.indices{
            if index%7 == 0
            {
                if dArray.count == 7
                {
                    dayArry[indexValue] = dArray
                }
                dArray = [DayItem]()
                indexValue += 1
            }
            dArray.append(DayItem(id: index, tileString: arrayDayString[index]))
        }
        dayArry[indexValue]  = dArray
        numberOfRows = indexValue
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        monthString = dateFormatter.string(from: date)
        objectWillChange.send()
    }
}
struct DayItem:Identifiable {
    let id: Int
    let tileString:String
    
}
