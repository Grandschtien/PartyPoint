//
//  ChooseCityContentView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 08.05.2023.
//  
//

import SnapKit
import UIKit

private let CLOSE_BUTTON_SIZE: CGFloat = 30.scale()
private let CLOSE_BUTTON_RIGHT_INSET: CGFloat = 20
private let CLOSE_BUTTON_TOP_OFFSET: CGFloat = 20
private let TITLE_TOP_OFFSET: CGFloat = 20
private let TITLE_FONT_SIZE: CGFloat = 16.scale()
private let TABLEVIEW_BOTTOM_OFFSET: CGFloat = 10
private let BUTTON_HEIGHT: CGFloat = 56.scale()
private let BUTTON_HORIZONTAL_INSETS: CGFloat = 35
private let BUTTON_BOTTOM_INSET: CGFloat = 80.scale()
private let BUTTON_TOP_INSET: CGFloat = 25

final class ChooseCityContentView: UIView {
    
    private var closeAction: EmptyClosure?
    private var confirmChose: EmptyClosure?
    
    // MARK: Private properties
    private let closeButton = UIButton()
    private let tableView = UITableView()
    private let titleLabel = UILabel()
    private let confirmButton = PPButton(style: .primary, size: .m)
    private lazy var adapter = ChooseCityAdapter(tableView: tableView)
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
}

// MARK: Private methods
private extension ChooseCityContentView {
    func setupUI() {
        self.backgroundColor = PartyPointAsset.mainColor.color
        
        self.addSubview(titleLabel)
        self.addSubview(closeButton)
        self.addSubview(tableView)
        self.addSubview(confirmButton)
        
        setupConstraints()
        
        setupCloseButton()
        setupTableView()
        setupTitleLabel()
        setupConfirmButton()
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints  {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(TITLE_TOP_OFFSET)
        }
        
        closeButton.snp.makeConstraints {
            $0.size.equalTo(CLOSE_BUTTON_SIZE)
            $0.top.equalToSuperview().offset(CLOSE_BUTTON_TOP_OFFSET)
            $0.right.equalToSuperview().inset(CLOSE_BUTTON_RIGHT_INSET)
        }
        
        tableView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(closeButton.snp.bottom).offset(TABLEVIEW_BOTTOM_OFFSET)
            $0.bottom.equalTo(confirmButton.snp.top).offset(-BUTTON_TOP_INSET)
        }
        
        confirmButton.snp.makeConstraints {
            $0.height.equalTo(BUTTON_HEIGHT)
            $0.left.right.equalToSuperview().inset(BUTTON_HORIZONTAL_INSETS)
            $0.bottom.equalToSuperview().inset(BUTTON_BOTTOM_INSET)
        }
    }
    
    func setupCloseButton() {
        closeButton.backgroundColor = PartyPointAsset.miniColor.color.withAlphaComponent(0.7)
        closeButton.layer.cornerRadius = CLOSE_BUTTON_SIZE / 2
        closeButton.addTarget(self, action: #selector(closeActionHadler), for: .touchUpInside)
        closeButton.setImage(PartyPointAsset.closeButton.image, for: .normal)
    }
    
    func setupTableView() {
        tableView.backgroundColor = PartyPointAsset.mainColor.color
        tableView.delegate = adapter
        tableView.dataSource = adapter
        tableView.allowsMultipleSelection = false
        tableView.registerCell(cellType: CityCell.self)
    }
    
    func setupTitleLabel() {
        titleLabel.font = PartyPointFontFamily.SFProDisplay.bold.font(size: TITLE_FONT_SIZE)
        titleLabel.textColor = PartyPointAsset.miniColor.color
        titleLabel.text = PartyPointStrings.Localizable.selectCity
    }
    
    func setupConfirmButton() {
        confirmButton.setTitle( PartyPointStrings.Localizable.done, for: .normal)
        confirmButton.addTarget(self, action: #selector(confirmChoseHandler), for: .touchUpInside)
    }
}

// MARK: Public methods
extension ChooseCityContentView {
    func setCloseAction(_ action: @escaping EmptyClosure) {
        self.closeAction = action
    }
    
    func setConfirmChoseAction(_ action: @escaping EmptyClosure) {
        self.confirmChose = action
    }
    
    func setChosenCity(_ city: String) {
        self.adapter.setChosenCity(city: city)
    }
    
    func setChooseCityAction(_ action: @escaping (String) -> Void) {
        adapter.setChooseCityAction(action)
    }
}

// MARK: Action methods
private extension ChooseCityContentView {
    @objc
    func closeActionHadler() {
        closeAction?()
    }
    
    @objc
    func confirmChoseHandler() {
        confirmChose?()
    }
}

