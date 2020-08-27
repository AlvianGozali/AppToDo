//
//  GroupedActivities.swift
//  myapp2
//
//  Created by Alvian Gozali on 13/03/20.
//  Copyright © 2020 Alvian Gozali. All rights reserved.
//

import Foundation

class GroupedActivities {
    private var day: String
    private var activities = [Activity]()
    
    init(_ day: String) {
        self.day = day
    }
    
    //CLASS SETTER GETTER
    
    func getActivities() -> [Activity] {
        return self.activities
    }
    
    func getSection() -> String {
        return self.day
    }
    
    // CLASS BEHAVIOUR
    
    func addActivity(_ activity: Activity){
        activities.append(activity)
    }
    
    func removeActivity(_ index: Int) {
        activities.remove(at: index)
    }
}
