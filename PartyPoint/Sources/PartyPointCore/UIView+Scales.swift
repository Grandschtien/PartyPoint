//
//  UIView+Scales.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 19.08.2022.
//

import Foundation
import UIKit

extension UIView {
    
    public static var onePixel: CGFloat {
        return 1.0 / screenScale
    }

    public static var screenScale: CGFloat {
        return UIScreen.main.scale
    }

    public static var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    public static var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    public static var screenScaleFactor: CGFloat {
        let maketWidth: CGFloat = 375
        let screenWidth = UIView.screenWidth
        let scalingFactor = screenWidth / maketWidth
        return scalingFactor
    }
    
    public static var heightScreenScaleFactor: CGFloat {
        let maketHeight: CGFloat = 812
        let screenHeight = UIView.screenHeight
        return screenHeight / maketHeight
    }
}
