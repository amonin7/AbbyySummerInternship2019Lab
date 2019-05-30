//
//  Task.swift
//  Task tracker
//
//  Created by Andrey Minin on 29/05/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

import Foundation

class Task: NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(taskName, forKey: "name")
        aCoder.encode(taskDate, forKey: "date")
        aCoder.encode(taskDescription, forKey: "descr")
        aCoder.encode(status, forKey: "stat")
    }
    
    required init?(coder aDecoder: NSCoder) {
        taskName = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        taskDate = aDecoder.decodeObject(forKey: "date") as? Date ?? Date()
        taskDescription = aDecoder.decodeObject(forKey: "descr") as? String ?? ""
        status = aDecoder.decodeObject(forKey: "stat") as? String ?? "Выполняется"
    }
    
    var taskName: String
    var taskDate: Date
    var taskDescription: String
    var status: String
    
    init(name: String, date: Date, descr: String, stat: String) {
        taskName = name
        taskDate = date
        taskDescription = descr
        status = stat
    }
}

var taskList: [Task] = UserDefaults.takeList()

