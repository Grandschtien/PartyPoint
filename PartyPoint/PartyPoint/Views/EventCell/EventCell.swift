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
        
        destinationLabel.font = Fonts.sfProDisplayRegular(size: 15)
        destinationLabel.textColor = Colors.miniColor()
        destinationView.layer.cornerRadius = 5
        
        destinationView.backgroundColor = Colors.mainColor()
        destinationView.clipsToBounds = true
        nameLabel.font = Fonts.sfProDisplayBold(size: 30)
        nameLabel.textColor = Colors.miniColor()
        dateLabel.font = Fonts.sfProDisplaySemibold(size: 20)
        likeView.layer.cornerRadius = 10
        likeView.backgroundColor = Colors.miniColor()
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
