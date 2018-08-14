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
        fetchURL(url: "https://webservices.vividseats.com/rest/mobile/v1/home/cards",param: ["startDate": "2018-8-14","endDate": "2018-8-18","includeSuggested": "true"])

    }
    

    func fetchURL(url:String,param:[String:Any]){
        
//        Alamofire.request(url, method: .post,parameters:param)
//            .responseString{(response) in
//            print(response.value ?? "no value")
//            
//            
//            }.responseJSON{
//                response in
//                
//                debugPrint(response)
//        }
        
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
        }

    }
   


}

