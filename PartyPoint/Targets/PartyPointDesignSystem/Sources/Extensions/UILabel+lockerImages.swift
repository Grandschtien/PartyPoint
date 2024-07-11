//
//  UILabel+lockerImages.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 21.12.2022.
//

import UIKit
import PartyPointResources

extension UILabel {
    func addLockerIcon(iconColor: UIColor) {
        guard let attrStr = attributedText,
            !attrStr.string.isEmpty else {
            return
        }

        let img = PartyPointResourcesAsset.icLabelLocker.image.withRenderingMode(.alwaysTemplate)

        let fullString = NSMutableAttributedString(attributedString: attrStr)
        
        fullString.append(NSAttributedString(string: " ", attributes: attrStr.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, attrStr.length))))
        
        let lockAttachment = NSTextAttachment()
        lockAttachment.bounds = CGRect(x: 0,
                                       y: (font.capHeight - img.size.height).rounded() / 2,
                                       width: img.size.width,
                                       height: img.size.height)
        lockAttachment.image = img

        let imageString = NSMutableAttributedString(attachment: lockAttachment)

        imageString.addAttributes([.foregroundColor : iconColor],
                                  range: NSRange(location: 0, length: imageString.length))

        fullString.append(imageString)

        attributedText = fullString
    }
}
