//
//  NavigationBarWithLogo.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import UIKit
import PartyPointResources

private let TITLE_LABLE_FONT_SIZE: CGFloat = 20.scale()
private let NAVIGATION_BAR_HEIGHT: CGFloat = 78.scale()
private let TITLE_IMAGE_HEIGHT: CGFloat = 66.scale()
private let TITLE_IMAGE_WIDTH: CGFloat = 132.scale()

open class NavigationBarWithLogo: UIView {
    
    internal lazy var imageView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.contents = PartyPointResourcesAsset.logo.image.cgImage
        return view
    }()
    
    internal lazy var title: UILabel = {
       let label = UILabel()
        label.font = PartyPointResourcesFontFamily.SFProDisplay.bold.font(size: TITLE_LABLE_FONT_SIZE)
        label.textColor = PartyPointResourcesAsset.miniColor.color
        return label
    }()
    
    var height: CGFloat {
        return NAVIGATION_BAR_HEIGHT
    }
    
    public init(background: UIColor = .clear,
         image: UIImage? = PartyPointResourcesAsset.logo.image,
         frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = background
        self.imageView.layer.contents = image?.cgImage
        configure()
    }
    
    required public init?(coder: NSCoder) {
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
