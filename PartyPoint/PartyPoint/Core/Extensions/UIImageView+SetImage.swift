//
//  UIImageView+SetImage.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 04.01.2023.
//

import UIKit

extension UIImageView {
    func setImage(url: URL?) {
        Task {
            do {
                let imageData = try await PhotoManager.loadPhoto(url: url)
                self.image = UIImage(data: imageData)
            } catch {
                self.image = nil
            }
        }
    }
}
