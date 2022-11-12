//
//  EventCell.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 15.07.2022.
//

import UIKit

private let DESTIONATION_FONT: CGFloat = 15 * SCREEN_SCALE_BY_HEIGHT
private let NAME_FONT: CGFloat = 30 * SCREEN_SCALE_BY_HEIGHT
private let DATE_FONT: CGFloat = 20 * SCREEN_SCALE_BY_HEIGHT

class EventCell: UICollectionViewCell {
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var destinationView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeView: UIView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var image: UIView!
//    private let nameLabel = UILabel()
//    private let destinationLabel = UILabel()
//    private let destinationImage = UIImageView()
//    private let destinationView = UIView()
//    private let likeView = UIView()
//    private let likeImage = UIImageView()
//    private let dateLabel = UILabel()
//
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func configure(withEvent event: Event) {
        self.destinationLabel.text = "\(event.distance) км"
        self.nameLabel.text = event.name
        self.dateLabel.text = event.date
        self.image.layer.contents = UIImage(named: event.image)?.cgImage
    }
}

//MARK: Private methods
private extension EventCell {
    func setupUI() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        
//        self.contentView.addSubview(nameLabel)
//        self.contentView.addSubview(dateLabel)
//        self.contentView.addSubview(destinationView)
//        self.contentView.addSubview(likeView)
        destinationLabel.font = Fonts.sfProDisplayRegular(size: DESTIONATION_FONT)
        destinationLabel.textColor = Colors.miniColor()
        destinationView.layer.cornerRadius = 5
        destinationView.backgroundColor = Colors.mainColor()
        destinationView.clipsToBounds = true
        
        nameLabel.font = Fonts.sfProDisplayBold(size: NAME_FONT)
        nameLabel.textColor = Colors.miniColor()
        
        dateLabel.font = Fonts.sfProDisplaySemibold(size: DATE_FONT)
        dateLabel.textColor = Colors.miniColor()
        
        likeView.layer.cornerRadius = 10
        likeView.backgroundColor = Colors.miniColor()
        likeView.layer.opacity = 0.6
        likeView.clipsToBounds = true
        likeView.layer.allowsGroupOpacity = false
    }
}
