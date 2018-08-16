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
    
    //MARK: Arrays to populate Table View.
    var allEvents = [Event]()
    var allEventsFiltered = [Event]()
    var favEvents = [Event]()
    var favEventsFiltered = [Event]()
    var isFiltering = false
    
    
    //MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    //Create an enum for the segmented control indexes to make it more readable
    private enum Segments: Int {
        case Suggested = 0, Favorites
    }
    
    //MARK: App lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let dateString = Date().convertToString(format: "yyyy-M-d")
        fetchURL(url: "https://webservices.vividseats.com/rest/mobile/v1/home/cards",param: ["startDate": dateString,"endDate": "2018-8-18","includeSuggested": "true"])

    }
    
    //MARK: Network methods
    
    func fetchURL(url:String,param:[String:Any]){
        
        //Fetch the events from server and parse into an array of events using the decodable protocol
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default)
            .responseJSON { response in
                self.allEvents = try! JSONDecoder().decode(Array<Event>.self, from: response.data!)
                DispatchQueue.main.async(){
                    self.tableView.reloadData()
                }
        }
    }
    
    //Choose the correct array considering if it's the suggested or favorite tab and if it's being filtered by the search bar or not.
    func findCurrentArray() -> [Event]{
        let selectedSegment = Segments(rawValue: self.segmentedControl.selectedSegmentIndex)!
        switch selectedSegment {
        case .Suggested:
            return isFiltering ? allEventsFiltered : allEvents
        case .Favorites:
            return isFiltering ? favEventsFiltered : favEvents
        }
    }
    
    //Called when the like button is tapped
    @objc func tappedButton(sender : UIButton){
        var currentArray = findCurrentArray()
        let event = currentArray[sender.tag]
        
        //An array of entityId(integers) is saved using User Defaults so that it persists after the app is killed. This array is then used to filter the favorites from the main array and create a new favorites array.
        let defaults = UserDefaults.standard
        var array = defaults.array(forKey: "favorites")  as? [Int] ?? [Int]()
        if(array.contains(event.entityId)){
            array = array.filter { $0 != event.entityId }
        }else{
            array.append(event.entityId)
        }
        defaults.set(array, forKey: "favorites")
        
        //If favorite array delete event from list otherwise the number of cells on the table view wouldn't match the number of elements on array.
        // If not favorite just reload the individual cell
        let selectedSegment = Segments(rawValue: self.segmentedControl.selectedSegmentIndex)!
        switch selectedSegment {
        case .Suggested:
            let indexPath = IndexPath(item: sender.tag, section: 0)
            tableView.reloadRows(at: [indexPath], with: .none)
        case .Favorites:
            let indexPath = IndexPath(item: sender.tag, section: 0)
            if(isFiltering){
                favEventsFiltered.remove(at: indexPath.row)
                self.tableView.reloadData()
            }else{
                favEvents.remove(at: indexPath.row)
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        updateTableViewWithFilteredContent()
    }
    
    func updateTableViewWithFilteredContent(){
        let index = segmentedControl.selectedSegmentIndex
        let selectedSegment = Segments(rawValue: index)!
        switch selectedSegment {
        case .Suggested:
            textChanged(searchText: searchBar.text!)
        case .Favorites:
            self.favEvents = self.allEvents.filter{$0.favorite}
            textChanged(searchText: searchBar.text!)
        }
        tableView.reloadData()
    }
    
    func textChanged(searchText
        :String){
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
        
        //Wait 0.2 seconds for the tableView to reload before scrolling to the top
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            let currentEvents = self.isFiltering ? self.favEventsFiltered : self.favEvents
            if(currentEvents.count > 0){
                let topIndex = IndexPath(row: 0, section: 0)
                self.tableView.scrollToRow(at: topIndex, at: .top, animated: true)
            }
        })
    }
    
    //MARK: searchBar Delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Dismiss keyboard
        self.searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       textChanged(searchText: searchText)
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
        cell.heartButton.addTarget(self, action: #selector(self.tappedButton(sender:)), for: .touchUpInside);
        
        let event = currentEvents[indexPath.row]
        cell.configureCell(event: event)
        cell.heartButton.tag = indexPath.row
        
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

