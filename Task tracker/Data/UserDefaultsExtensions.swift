//
//  UserDefaultsExtensions.swift
//  Task tracker
//
//  Created by Andrey Minin on 29/05/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

import Foundation

extension UserDefaults {
    class func saveListToUD(list: [Task]) {
        let listToSave = list
        if let data = try? NSKeyedArchiver.archivedData(withRootObject: listToSave, requiringSecureCoding: false) {
            UserDefaults.standard.set(data, forKey: "userTaskList")
            UserDefaults.standard.synchronize()
        } else {
            print("error")
        }
    }
    class func takeList() -> [Task] {
        if let savedTasks = UserDefaults.standard.object(forKey: "userTaskList") as? Data {
            if let decodedTasks = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedTasks) as? [Task] {
                return decodedTasks ?? []
            } else {
                return []
            }
        } else {
            return []
        }
    }
    
}
