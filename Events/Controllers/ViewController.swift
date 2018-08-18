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
    
    //MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var currentEvents:[Event] {
        return Events.findCurrentArray(segmentedControlSelectedValue: self.segmentedControl.selectedSegmentIndex, searchText: self.searchBar.text!)
    }
    
    //MARK: App lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchEvents()
    }
    
    func fetchEvents(){
        let dateString = Date().convertToString(format: "yyyy-M-d")
        AlamofireManager.fetchURL(url: "https://webservices.vividseats.com/rest/mobile/v1/home/cards", param: ["startDate": dateString,"endDate": "2018-8-18","includeSuggested": "true"], completion: { [weak self] data in
            Events.all = data
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }})
    }
    
    //Called when the like button is tapped
    @objc func tappedButton(sender : UIButton){
        let hitPoint = sender.convert(CGPoint.zero, to: tableView)
        guard let indexPath = tableView.indexPathForRow(at: hitPoint) else {return}
        var currentArray = Events.findCurrentArray(segmentedControlSelectedValue: self.segmentedControl.selectedSegmentIndex, searchText: self.searchBar.text!)
        let event = currentArray[indexPath.row]
        event.updateFavoritesArray()
        
        let selectedSegment = Events.findCurrentSegment(segmentedControl: self.segmentedControl)
        switch selectedSegment {
        case .Suggested:
            self.tableView.reloadRows(at: [indexPath], with: .none)
        case .Favorites:
            if(Events.isFiltering){
                Events.favoritesFiltered.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }else{
                Events.favorites.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        updateTableViewWithFilteredContent()
    }
    
    func updateTableViewWithFilteredContent(){
        let selectedSegment = Events.findCurrentSegment(segmentedControl: self.segmentedControl)
        switch selectedSegment {
        case .Suggested:
            textChanged(searchText: searchBar.text!)
        case .Favorites:
            Events.favorites = Events.all.filter{$0.favorite}
            textChanged(searchText: searchBar.text!)
        }
        tableView.reloadData()
    }
    
    func textChanged(searchText
        :String){
        if (searchText.count>0) {
            Events.allFiltered = Events.all.filter {
                $0.topLabel.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            }
            Events.favoritesFiltered = Events.favorites.filter {
                $0.topLabel.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            }
        }
        else
        {
            Events.allFiltered = Events.all
            Events.favoritesFiltered = Events.favorites
        }
        self.tableView.reloadData()
        
        //Wait 0.2 seconds for the tableView to reload before scrolling to the top
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            if(self.currentEvents.count > 0){
                let topIndex = IndexPath(row: 0, section: 0)
                self.tableView.scrollToRow(at: topIndex, at: .top, animated: true)
            }
        })
    }
    
    //MARK: searchBar Delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       textChanged(searchText: searchText)
    }
    
    //MARK: tableView Delegate & Data Source
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! EventTableViewCell
        cell.heartButton.addTarget(self, action: #selector(self.tappedButton(sender:)), for: .touchUpInside);
        
        let event = self.currentEvents[indexPath.row]
        cell.configureCell(event: event)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentEvents.count
}
}
