//
//  EventInfoList.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 19.08.2022.
//

import UIKit
import SnapKit

final class EventInfoList: UIView {
    
    private lazy var header: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.SFProDisplayBold, size: 36)
        label.textColor = .white
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.registerNib(cellType: LocationCell.self)
        table.registerNib(cellType: DescriptionCell.self)
        table.registerNib(cellType: EventWithButtonCell.self)
        table.registerNib(cellType: MapCell.self)
        table.register(EventHeader.self, forHeaderFooterViewReuseIdentifier: EventHeader.reuseIdentifier)
        return table
    }()
    
    private lazy var adapter = EventInfoListAdapter(tableView)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension EventInfoList {
    func setupUI() {
        self.addSubview(header)
        
        header.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            
        }
        
        self.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
