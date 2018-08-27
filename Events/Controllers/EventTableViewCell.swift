//
//  EventTableViewCell.swift
//  Events
//
//  Created by Joao Paulo Aquino on 2018-08-14.
//  Copyright © 2018 Joao Paulo Aquino. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventDatesLabel: UILabel!
    @IBOutlet weak var numberOfEventsLabel: UILabel!
    
    var eventViewModel:EventViewModel!
    
    func configureCell(eventViewModel:EventViewModel){
        self.eventViewModel = eventViewModel
        self.artistNameLabel.text = eventViewModel.topLabel
        self.eventLocationLabel.text = eventViewModel.middleLabel
        self.eventImageView.image =  nil
        self.eventDatesLabel.text = eventViewModel.bottomLabel
        self.numberOfEventsLabel.text = eventViewModel.numberOfEventsString
        self.eventImageView.kf.setImage(with: eventViewModel.imageURL)
        self.heartButton.setImage(eventViewModel.heartImage, for: .normal)
    }
    
}
