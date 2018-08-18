//
//  AlamofireManager.swift
//  Events
//
//  Created by Joao Paulo Aquino on 2018-08-17.
//  Copyright © 2018 Joao Paulo Aquino. All rights reserved.
//

import Foundation
import Alamofire

struct AlamofireManager{
    
    static func fetchURL(completion: @escaping ([Event]) -> Void){
        let dateString = Date().convertToString(format: "yyyy-M-d")
        let oneWeekFromNow = Date().addDaysToCurrentDate(n: 7)
        let oneWeekFromNowString = oneWeekFromNow.convertToString(format: "yyyy-M-d")
    
    //Fetch the events from server and parse into an array of events using the decodable protocol
    Alamofire.request("https://webservices.vividseats.com/rest/mobile/v1/home/cards", method: .post, parameters: ["startDate": dateString,"endDate": oneWeekFromNowString,"includeSuggested": "true"], encoding: JSONEncoding.default)
        .responseJSON(completionHandler: {response -> Void in
            
            switch response.result {
            case .success(let value):
                print("value \(value)")
                let allEvents:[Event] = try! JSONDecoder().decode(Array<Event>.self, from: response.data!)
                completion(allEvents)
            case .failure(let error):
                print(error)
                completion([])
            }
        })
}
}

