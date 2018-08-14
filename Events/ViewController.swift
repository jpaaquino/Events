//
//  ViewController.swift
//  Events
//
//  Created by Joao Paulo Aquino on 2018-08-13.
//  Copyright © 2018 Joao Paulo Aquino. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let dateString = Date().convertToString(format: "yyyy-M-d")
        fetchURL(url: "https://webservices.vividseats.com/rest/mobile/v1/home/cards",param: ["startDate": dateString,"endDate": "2018-8-18","includeSuggested": "true"])

    }
    

    func fetchURL(url:String,param:[String:Any]){
        
        
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default)
            .responseJSON { response in
                let allEvents = try! JSONDecoder().decode(Array<Event>.self, from: response.data!)
                print(allEvents)

                    }
                }
   

}

