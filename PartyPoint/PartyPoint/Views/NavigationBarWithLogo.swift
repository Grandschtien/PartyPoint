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
    
    internal lazy var title: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: UIFont.SFProDisplayBold, size: 20)
        label.textColor = .miniColor
        return label
    }()
    
    
    init(background: UIColor = .clear,
         image: UIImage? = .logo,
         frame: CGRect) {
        let navFrame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: 78)
        super.init(frame: navFrame)
        self.backgroundColor = background
        self.imageView.layer.contents = image?.cgImage
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.addSubview(title)
        title.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        self.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
            $0.height.equalTo(66.scale())
            $0.width.equalTo(132.scale())
        }
        self.snp.makeConstraints {
            $0.height.equalTo(78)
        }
    }
}
