//
//  Event.swift
//  Events
//
//  Created by Joao Paulo Aquino on 2018-08-14.
//  Copyright © 2018 Joao Paulo Aquino. All rights reserved.
//

import Foundation

struct Event: Decodable {
    var bottomLabel:String
    var entityId:Int
    var entityType:String
    var image:String
    //TODO:Add remaining params
}


