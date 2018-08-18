//
//  Events.swift
//  Events
//
//  Created by Joao Paulo Aquino on 2018-08-17.
//  Copyright © 2018 Joao Paulo Aquino. All rights reserved.
//

import UIKit

struct Events {
    static var all = [Event]()
    static var allFiltered = [Event]()
    static var favorites = [Event]()
    static var favoritesFiltered = [Event]()
    static var isFiltering = false
    
    enum Segments: Int {
        case Suggested = 0, Favorites
    }
    
    //Choose the correct array considering if it's the suggested or favorite tab and if it's being filtered by the search bar or not.
    static func findCurrentArray(segmentedControlSelectedValue:Int,searchText:String) -> [Event]{
       
        Events.isFiltering = searchText == "" ? false : true
        let selectedSegment = Segments(rawValue: segmentedControlSelectedValue)!
        switch selectedSegment {
        case .Suggested:
            return Events.isFiltering ? Events.allFiltered : Events.all
        case .Favorites:
            return Events.isFiltering ? Events.favoritesFiltered : Events.favorites
        }
    }
    
    static func findCurrentSegment(segmentedControl:UISegmentedControl) -> Segments{
        return Segments(rawValue: segmentedControl.selectedSegmentIndex)!
}
    
}
