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
    
    var event:Event?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //addGradientToImage()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func likeAction(_ sender: UIButton) {
        guard let event = self.event else {return}
        let defaults = UserDefaults.standard
        var array = defaults.array(forKey: "favorites")  as? [Int] ?? [Int]()
        if(array.contains(event.entityId)){
            array = array.filter { $0 != event.entityId }
        }else{
            array.append(event.entityId)
        }
        defaults.set(array, forKey: "favorites")
        updateHeartButton()
        
    }
    
    
    func configureCell(event:Event){
        self.event = event
        self.artistNameLabel.text = event.topLabel
        self.eventLocationLabel.text = event.middleLabel
        self.eventImageView.image =  nil
        //self.heartButton.setImage(#imageLiteral(resourceName: "icons8-heart-white"), for: .normal)
        updateHeartButton()
        self.eventDatesLabel.text = event.bottomLabel
        self.numberOfEventsLabel.text = "\(event.eventCount) events ＞"
        
        Alamofire.request(event.image, method: .get).responseJSON { response in
            self.eventImageView.image = UIImage(data: response.data!, scale:1)
        }
    }
        
        func updateHeartButton(){
            guard let event = self.event else {return}
            
            let defaults = UserDefaults.standard
            var array = defaults.array(forKey: "favorites")  as? [Int] ?? [Int]()
            if(array.contains(event.entityId)){
                heartButton.setImage(#imageLiteral(resourceName: "icons8-heart-red"), for: .normal)
                
            }else{
                array.append(event.entityId)
                heartButton.setImage(#imageLiteral(resourceName: "icons8-heart-white"), for: .normal)
            }
        }
    
}
