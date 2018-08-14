//
//  EventTableViewCell.swift
//  Events
//
//  Created by Joao Paulo Aquino on 2018-08-14.
//  Copyright © 2018 Joao Paulo Aquino. All rights reserved.
//

import UIKit
import Alamofire

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventDatesLabel: UILabel!
    @IBOutlet weak var numberOfEventsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(event:Event){
        self.artistNameLabel.text = event.topLabel
        self.eventLocationLabel.text = event.middleLabel
        self.eventImageView.image =  nil
        self.heartButton.setImage(#imageLiteral(resourceName: "icons8-heart-white"), for: .normal)
        self.eventDatesLabel.text = event.bottomLabel
        self.numberOfEventsLabel.text = "\(event.eventCount) events ＞"
        
        Alamofire.request(event.image, method: .get).responseJSON { response in
            self.eventImageView.image = UIImage(data: response.data!, scale:1)
        }
        
   
        
    }

}
