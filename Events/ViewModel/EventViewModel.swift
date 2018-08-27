//
//  EventViewModel.swift
//  Events
//
//  Created by Joao Paulo on 2018-08-26.
//  Copyright © 2018 Joao Paulo Aquino. All rights reserved.
//

import UIKit

struct EventViewModel {
    
    let event: Event
    var topLabel: String {
        return self.event.topLabel
    }
    var middleLabel:String{
      return self.event.middleLabel
    }
    var bottomLabel:String{
      return self.event.bottomLabel
    }
    var entityId:Int{
      return self.event.entityId
    }
    var eventCount:Int{
      return self.event.eventCount
    }
    var targetId:Int {
        return self.event.targetId
    }
    var targetType:String {
        return self.event.targetType
    }
    var startDate: Int{
        return self.event.startDate
    }
    var rank: Int {
        return self.event.rank
    }
    var entityType:String{
        return self.event.entityType
    }
    var image:String {
        return self.event.image
    }
    var favorite:Bool  {
        let defaults = UserDefaults.standard
        let array = defaults.array(forKey: "favorites")  as? [Int] ?? [Int]()
        return array.contains(self.event.entityId) ? true : false
    }
    
    var heartImage: UIImage {
        let defaults = UserDefaults.standard
        let array = defaults.array(forKey: "favorites")  as? [Int] ?? [Int]()
        if(array.contains(self.event.entityId)){
            return UIImage(named: "icons8-heart-red")!
        }else{
            return UIImage(named: "icons8-heart-white")!
        }
    }
    
    var numberOfEventsString: String {
        return "\(self.eventCount) events ＞"
    }
    
    var imageURL: URL?{
        return URL(string: self.image)
    }
    
    init(event:Event){
        self.event = event
    }
    
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
