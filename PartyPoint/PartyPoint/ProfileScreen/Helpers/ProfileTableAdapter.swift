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
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
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
            return UITableViewCell()
        case 1:
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
}
extension ProfileTableAdapter: UITableViewDelegate {
    
}
