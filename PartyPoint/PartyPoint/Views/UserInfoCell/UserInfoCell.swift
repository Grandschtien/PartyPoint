//
//  UserInfoCell.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 20.07.2022.
//

import UIKit

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
        nameLabel.font = Fonts.sfProDisplayRegular(size: 20)
        nameLabel.textColor = Colors.miniColor()
        ageLabel.font = Fonts.sfProDisplayRegular(size: 14)
        ageLabel.textColor = Colors.miniColor()
        dobLabel.font = Fonts.sfProDisplayRegular(size: 14)
        dobLabel.textColor = Colors.miniColor()
    }
}
