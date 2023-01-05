//
//  PhotoManager.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 04.01.2023.
//

import Foundation

final class DownloadingImageManager {
    static func loadPhoto(url: URL, completion: @escaping (Data?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if error != nil {
                debugPrint("[DEBUG] - image wih url \(url.absoluteString) didn't load")
                return
            }
            
            DispatchQueue.main.async {
                completion(data)
            }
        }.resume()
    }
}
