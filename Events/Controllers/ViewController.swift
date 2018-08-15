//
//  ViewController.swift
//  Events
//
//  Created by Joao Paulo Aquino on 2018-08-13.
//  Copyright © 2018 Joao Paulo Aquino. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate {
    
    var allEvents = [Event]()
    var allEventsFiltered = [Event]()
    
    var favEvents = [Event]()
    var favEventsFiltered = [Event]()
    
    var isFiltering = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    private enum Segments: Int {
        case Suggested = 0, Favorites
    }
    
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
                self.allEvents = try! JSONDecoder().decode(Array<Event>.self, from: response.data!)
                DispatchQueue.main.async(){
                    self.tableView.reloadData()
                }
                    }
                }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let selectedSegment = Segments(rawValue: sender.selectedSegmentIndex)!
        switch selectedSegment {
        case .Suggested:
            tableView.reloadData()
            let topIndex = IndexPath(row: 0, section: 0)
            tableView.scrollToRow(at: topIndex, at: .top, animated: false)

        case .Favorites:
            self.favEvents = self.allEvents.filter{$0.favorite}
            tableView.reloadData()
            let topIndex = IndexPath(row: 0, section: 0)
            tableView.scrollToRow(at: topIndex, at: .top, animated: false)
            
        }
    }
    
    //MARK: searchBar Delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.count>0) {
            isFiltering = true
            allEventsFiltered = allEvents.filter {
                $0.topLabel.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            }
            favEventsFiltered = favEvents.filter {
                $0.topLabel.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            }
            print(allEventsFiltered)
        }
        else
        {
            isFiltering = false
            allEventsFiltered = allEvents
            favEventsFiltered = favEvents

        }
        self.tableView.reloadData()
    }
    
    //MARK: tableView Delegate & Data Source
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! EventTableViewCell
            let selectedSegment = Segments(rawValue: self.segmentedControl.selectedSegmentIndex)!
            var currentEvents = [Event]()
            switch selectedSegment {
            case .Suggested:
                currentEvents = isFiltering ? allEventsFiltered : allEvents
            case .Favorites:
                currentEvents = isFiltering ? favEventsFiltered : favEvents
            }
      
            let event = currentEvents[indexPath.row]
            cell.configureCell(event: event)
                        
            return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let selectedSegment = Segments(rawValue: self.segmentedControl.selectedSegmentIndex)!
        switch selectedSegment {
        case .Suggested:
            return isFiltering == true ? allEventsFiltered.count : allEvents.count
        case .Favorites:
            return isFiltering == true ? favEventsFiltered.count : favEvents.count
        }
        
    }

}

