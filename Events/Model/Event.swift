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
    
//    var favorite:Bool  {
//        let defaults = UserDefaults.standard
//        let array = defaults.array(forKey: "favorites")  as? [Int] ?? [Int]()
//        return array.contains(entityId) ? true : false
//    }
    
    func updateFavoritesArray(){
        //An array of entityId(integers) is saved using User Defaults so that it persists after the app is killed. This array is then used to filter the favorites from the main array and create a new favorites array.
        let defaults = UserDefaults.standard
        var array = defaults.array(forKey: "favorites")  as? [Int] ?? [Int]()
        if(array.contains(self.entityId)){
            array = array.filter { $0 != self.entityId }
        }else{
            array.append(self.entityId)
        }
        defaults.set(array, forKey: "favorites")
    }
}


