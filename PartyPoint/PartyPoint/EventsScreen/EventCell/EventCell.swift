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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeView: UIView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var image: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func configure(withEvent event: Event) {
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
