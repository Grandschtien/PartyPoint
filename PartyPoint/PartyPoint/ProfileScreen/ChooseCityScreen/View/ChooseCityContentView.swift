//
//  ChooseCityContentView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 08.05.2023.
//  
//

import SnapKit

private let CLOSE_BUTTON_SIZE: CGFloat = 35.scale()
private let CLOSE_BUTTON_RIGHT_INSET: CGFloat = 20.scale()
private let CLOSE_BUTTON_TOP_OFFSET: CGFloat = 20.scale()
private let TABLEVIEW_BOTTOM_OFFSET: CGFloat = 10

final class ChooseCityContentView: UIView {
    
    private var closeAction: EmptyClosure?
    
    // MARK: Private properties
    private let closeButton = UIButton()
    private let tableView = UITableView()
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
        self.backgroundColor = Colors.mainColor()
        
        self.addSubview(closeButton)
        self.addSubview(tableView)
        
        setupConstraints()
        
        setupCloseButton()
        setupTableView()
    }
    
    func setupConstraints() {
        closeButton.snp.makeConstraints {
            $0.size.equalTo(CLOSE_BUTTON_SIZE)
            $0.top.equalToSuperview().offset(CLOSE_BUTTON_TOP_OFFSET)
            $0.right.equalToSuperview().inset(CLOSE_BUTTON_RIGHT_INSET)
        }
        
        tableView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(closeButton.snp.bottom).offset(TABLEVIEW_BOTTOM_OFFSET)
            $0.bottom.equalToSuperview()
        }
    }
    
    func setupCloseButton() {
        closeButton.backgroundColor = Colors.miniColor()?.withAlphaComponent(0.7)
        closeButton.layer.cornerRadius = CLOSE_BUTTON_SIZE / 2
        closeButton.addTarget(self, action: #selector(closeActionHadler), for: .touchUpInside)
        closeButton.setImage(Images.close_button(), for: .normal)
    }
    
    func setupTableView() {
        tableView.backgroundColor = Colors.mainColor()
        tableView.delegate = adapter
        tableView.dataSource = adapter
        tableView.allowsMultipleSelection = false
        tableView.registerCell(cellType: CityCell.self)
    }
}

// MARK: Public methods
extension ChooseCityContentView {
    func setCloseAction(_ action: @escaping EmptyClosure) {
        self.closeAction = action
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
}

