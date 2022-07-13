//
//  NavigationBarWithLogo.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import UIKit

class NavigationBarWithLogo: UIView {
    
    internal lazy var imageView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.contents = UIImage.logo?.cgImage
        return view
    }()
    
    
    init(background: UIColor = .clear,
         image: UIImage? = .logo,
         frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = background
        self.imageView.layer.contents = image?.cgImage
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure() {
        self.addConstrained(subview: imageView,
                            top: 6,
                            left: 130,
                            bottom: -6,
                            right: -130)
    }
}
