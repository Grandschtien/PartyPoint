//
//  ProfileTableAdapter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 20.07.2022.
//

import Foundation
import UIKit

final class ProfileTableAdapter: NSObject {
    private weak var tableView: UITableView?
    
    private var userInfo: UserInfo?
    
    init(_ tableView: UITableView) {
        self.tableView = tableView
        super.init()
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
    }
    
    func configurate(withUserInfo userInfo: UserInfo) {
        self.userInfo = userInfo
        tableView?.reloadData()
    }
}

extension ProfileTableAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeue(cellType: UserInfoCell.self, for: indexPath)
            return cell
        case 1:
            let cell = tableView.dequeue(cellType: AboutMeCell.self, for: indexPath)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}
extension ProfileTableAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
}
