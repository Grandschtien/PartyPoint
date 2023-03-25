//
//  AcyncImageView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 04.01.2023.
//

import UIKit

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
        self.setDefaultImage()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    func setImage(url: URL?) {
        guard let url = url else {
            return
        }
        setDefaultImage()
        urlString = url.absoluteString
        
        
        if let imageFromCache = cache.object(forKey: "\(url.absoluteString)" as NSString) {
            image = imageFromCache
            return
        }
        
        DownloadingImageManager.loadPhoto(url: url) { [weak self] data in
            if let data = data {
                let imageForCache = UIImage(data: data)
                if self?.urlString == url.absoluteString {
                    self?.image = imageForCache
                }
                
                if let imageForCache = imageForCache {
                    self?.cache.setObject(imageForCache, forKey: "\(url.absoluteString)" as NSString)
                }
            }
        }
    }
    
    func setDefaultImage() {
        switch placeHolderType {
        case .profile:
            self.image = Images.profile_person()
        case .event:
            self.image = Images.image_placeholder()
        case .profileMain:
            self.image = Images.profile_image()
        }
    }
}
