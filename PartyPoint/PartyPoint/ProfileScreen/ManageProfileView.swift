//
//  ManageProfileView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 24.02.2023.
//

import SnapKit
final class ManageProfileView: UIView {
    private let mainLabel: UILabel = {
        let mainLabel = UILabel()
        mainLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        mainLabel.textColor = R.color.miniColor()
        return mainLabel
    }()
    
    private let manageView = UIView()
    
    private let manageLabel: UILabel = {
        let manageLabel = UILabel()
        manageLabel.textColor = R.color.stroke_color()
        manageLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return manageLabel
    }()
    
    private let manageArrow: UIImageView = {
        let manageArrow = UIImageView()
        manageArrow.image = R.image.calendar_chevron()
        manageArrow.tintColor = R.color.stroke_color()
        return manageArrow
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}

extension ManageProfileView {
    func setupUI() {
        self.backgroundColor = R.color.tabBarBarUnselected()
        self.clipsToBounds = true
        
        self.addSubview(mainLabel)
        mainLabel.snp.makeConstraints {
            $0.top.left.right.equalTo(self)
        }
        
        self.addSubview(manageView)
        manageView.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(20)
            $0.left.right.bottom.equalTo(self)
        }
        
    }
    
    func setupManageView() {
        manageView.addSubview(manageLabel)
        manageLabel.snp.makeConstraints {
            $0.edges.equalTo(manageView)
        }
        
        manageView.addSubview(manageArrow)
        manageArrow.snp.makeConstraints {
            $0.top.equalTo(manageView)
            $0.left.equalTo(manageLabel.snp.right)
        }
    }
    
    func configureMainLabel(with text: String) {
        mainLabel.text = text
    }
    
    func configureManageLabel(with text: String) {
        manageLabel.text = text
    }
}
