//
//  EventCell.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 15.07.2022.
//

import UIKit

class EventCell: UICollectionViewCell {
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var destinationView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeView: UIView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var image: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        //config destinationLabel
        
        destinationLabel.font = UIFont(name: UIFont.SFProDisplayRegular, size: 15)
        destinationLabel.textColor = .miniColor
        destinationView.layer.cornerRadius = 5
        
        destinationView.backgroundColor = .mainColor
        destinationView.clipsToBounds = true
        nameLabel.font = UIFont(name: UIFont.SFProDisplayBold, size: 30)
        nameLabel.textColor = .miniColor
        dateLabel.font = UIFont(name: UIFont.SFProDisplaySemibold, size: 20)
        likeView.layer.cornerRadius = 10
        likeView.backgroundColor = .miniColor
        likeView.layer.opacity = 0.6
        likeView.clipsToBounds = true
        likeView.layer.allowsGroupOpacity = false
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        
    }

    func configure(withEvent event: Event) {
        self.destinationLabel.text = "\(event.distance) км"
        self.nameLabel.text = event.name
        self.dateLabel.text = event.date
        self.image.layer.contents = UIImage(named: event.image)?.cgImage
    }
}
