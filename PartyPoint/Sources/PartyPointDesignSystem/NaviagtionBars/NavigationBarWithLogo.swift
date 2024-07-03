//
//  NavigationBarWithLogo.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import UIKit

private let TITLE_LABLE_FONT_SIZE: CGFloat = 20.scale()
private let NAVIGATION_BAR_HEIGHT: CGFloat = 78.scale()
private let TITLE_IMAGE_HEIGHT: CGFloat = 66.scale()
private let TITLE_IMAGE_WIDTH: CGFloat = 132.scale()

class NavigationBarWithLogo: UIView {
    
    internal lazy var imageView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.contents = R.image.logo()?.cgImage
        return view
    }()
    
    internal lazy var title: UILabel = {
       let label = UILabel()
        label.font = R.font.sfProDisplayBold(size: TITLE_LABLE_FONT_SIZE)
        label.textColor = R.color.miniColor()
        return label
    }()
    
    var height: CGFloat {
        return NAVIGATION_BAR_HEIGHT
    }
    
    init(background: UIColor = .clear,
         image: UIImage? = R.image.logo(),
         frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = background
        self.imageView.layer.contents = image?.cgImage
        configure()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    internal func setupConstraintsForTitle() {
        title.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

private extension NavigationBarWithLogo {
    func configure() {
        self.addSubview(title)
        self.addSubview(imageView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        setupConstraintsForTitle()
        
        imageView.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
            $0.height.equalTo(TITLE_IMAGE_HEIGHT)
            $0.width.equalTo(TITLE_IMAGE_WIDTH)
        }
        
        self.snp.makeConstraints {
            $0.height.equalTo(height)
        }
    }
}
