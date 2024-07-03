//
//  AcyncImageView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 04.01.2023.
//

import UIKit
import Kingfisher

final class AcyncImageView: UIImageView {
    
    enum DefaultPlaceHolder {
        case profileMain
        case profile
        case event
    }
    
    private let cache = NSCache<NSString, UIImage>()
    private var urlString: String?
    private let placeHolderType: DefaultPlaceHolder
    
    init(placeHolderType: DefaultPlaceHolder) {
        self.placeHolderType = placeHolderType
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    func setImage(url: URL?) {
        self.kf.setImage(with: url, placeholder: getDefaultPlaceholder(), options: [.cacheMemoryOnly])
    }
    
    func setDefaultImage() {
        image = getDefaultPlaceholder()
    }
    
    private func getDefaultPlaceholder() -> UIImage? {
        switch placeHolderType {
        case .profile:
            return R.image.profile_person()
        case .event:
            return R.image.image_placeholder()
        case .profileMain:
            return R.image.profile_image()
        }
    }
}
