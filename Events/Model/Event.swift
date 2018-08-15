//
//  Event.swift
//  Events
//
//  Created by Joao Paulo Aquino on 2018-08-14.
//  Copyright © 2018 Joao Paulo Aquino. All rights reserved.
//

import Foundation

struct Event: Decodable {
    var topLabel:String
    var middleLabel:String
    var bottomLabel:String
    var entityId:Int
    var eventCount:Int
    var targetId:Int
    var targetType:String
    var startDate: Int
    var rank: Int
    var entityType:String
    var image:String
    
    var favorite:Bool  {
        let defaults = UserDefaults.standard
        let array = defaults.array(forKey: "favorites")  as? [Int] ?? [Int]()
        return array.contains(entityId) ? true : false
    }
}


