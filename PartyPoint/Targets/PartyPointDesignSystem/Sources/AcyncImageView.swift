//
//  AcyncImageView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 04.01.2023.
//

import UIKit
import Kingfisher
import PartyPointResources

public final class AcyncImageView: UIImageView {
    
    public enum DefaultPlaceHolder {
        case profileMain
        case profile
        case event
    }
    
    private let cache = NSCache<NSString, UIImage>()
    private var urlString: String?
    private let placeHolderType: DefaultPlaceHolder
    
    public init(placeHolderType: DefaultPlaceHolder) {
        self.placeHolderType = placeHolderType
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        return nil
    }
    
    public func setImage(url: URL?) {
        self.kf.setImage(with: url, placeholder: getDefaultPlaceholder(), options: [.cacheMemoryOnly])
    }
    
    public func setDefaultImage() {
        image = getDefaultPlaceholder()
    }
    
    private func getDefaultPlaceholder() -> UIImage? {
        switch placeHolderType {
        case .profile:
            return PartyPointResourcesAsset.profilePerson.image
        case .event:
            return PartyPointResourcesAsset.imagePlaceholder.image
        case .profileMain:
            return PartyPointResourcesAsset.profileImage.image
        }
    }
}
