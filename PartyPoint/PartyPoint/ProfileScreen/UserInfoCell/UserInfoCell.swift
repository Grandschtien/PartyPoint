//
//  UserInfoCell.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 20.07.2022.
//

import UIKit

private let NAME_LABEL_FONT_SIZE: CGFloat = 20 * SCREEN_SCALE_BY_HEIGHT
private let AGE_LABEL_FONT_SIZE: CGFloat = 14 * SCREEN_SCALE_BY_HEIGHT
private let DOB_LABEL_FONT_SIZE: CGFloat = 14 * SCREEN_SCALE_BY_HEIGHT

final class UserInfoCell: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    private func setupUI() {
        self.selectionStyle = .none
        self.backgroundColor = Colors.mainColor()
        userImage.layer.cornerRadius = userImage.frame.height / 2
        userImage.clipsToBounds = true
        userImage.contentMode = .scaleAspectFill
        userImage.image = Images.personPhoto()
        userImage.backgroundColor = Colors.miniColor()
        nameLabel.font = Fonts.sfProDisplayRegular(size: NAME_LABEL_FONT_SIZE)
        nameLabel.textColor = Colors.miniColor()
        ageLabel.font = Fonts.sfProDisplayRegular(size: AGE_LABEL_FONT_SIZE)
        ageLabel.textColor = Colors.miniColor()
        dobLabel.font = Fonts.sfProDisplayRegular(size: DOB_LABEL_FONT_SIZE)
        dobLabel.textColor = Colors.miniColor()
    }
}
