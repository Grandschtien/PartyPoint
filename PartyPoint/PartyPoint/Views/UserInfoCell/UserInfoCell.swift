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
        self.backgroundColor = .mainColor
        userImage.layer.cornerRadius = userImage.frame.height / 2
        userImage.clipsToBounds = true
        userImage.contentMode = .scaleAspectFill
        userImage.image = .personPhoto
        userImage.backgroundColor = .miniColor
        nameLabel.font = UIFont(name: UIFont.SFProDisplayRegular, size: 20)
        nameLabel.textColor = .miniColor
        ageLabel.font = UIFont(name: UIFont.SFProDisplayRegular, size: 14)
        ageLabel.textColor = .miniColor
        dobLabel.font = UIFont(name: UIFont.SFProDisplayRegular, size: 14)
        dobLabel.textColor = .miniColor
    }
}
