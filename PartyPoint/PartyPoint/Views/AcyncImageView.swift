//
//  AcyncImageView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 04.01.2023.
//

import UIKit

final class AcyncImageView: UIImageView {
    private let cache = NSCache<NSString, UIImage>()
    private var urlString: String?
    
    func setImage(url: URL?) {
        guard let url = url else { return }
        
        urlString = url.absoluteString
        
        image = nil
        
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
}
