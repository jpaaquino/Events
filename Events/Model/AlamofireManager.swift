//
//  AlamofireManager.swift
//  Events
//
//  Created by Joao Paulo Aquino on 2018-08-17.
//  Copyright © 2018 Joao Paulo Aquino. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireManager{
    
class func fetchURL(url:String,param:[String:Any],completion: @escaping ([Event]) -> Void){
    
    //Fetch the events from server and parse into an array of events using the decodable protocol
    Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default)
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
