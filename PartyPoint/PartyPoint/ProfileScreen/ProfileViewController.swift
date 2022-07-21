//
//  ProfileViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private lazy var navigationBar: NavigationBarWithLogoAndActions = {
        let nav = NavigationBarWithLogoAndActions(frame: .zero, buttons: [.exit])
        nav.delegate = self
        return nav
    }()
    private lazy var userInfoTableView: UITableView = {
       let table = UITableView()
        table.registerNib(cellType: UserInfoCell.self)
        table.registerCell(cellType: AboutMeCell.self)
        table.backgroundColor = .mainColor
        table.separatorStyle = .none
        table.isScrollEnabled = false
        table.allowsSelection = false
        return table
    }()
    
    private lazy var userInfoTableAdapter: ProfileTableAdapter = {
        let adapter = ProfileTableAdapter(userInfoTableView)
        return adapter
    }()
	private let output: ProfileViewOutput

    init(output: ProfileViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let user = UserInfo(photo: "Concert", name: "Егор", bithdate: "16 ноября 2001", age: "20", aboutMe: "Я такой то такой то, отттуда то оттуда то и вот я тут")
        userInfoTableAdapter.configurate(withUserInfo: user)
    }
    
    private func setupUI() {
        view.backgroundColor = .mainColor
        view.addConstrained(subview: userInfoTableView, top: nil, left: 0, bottom: nil, right: 0)
        NSLayoutConstraint.activate([
            userInfoTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userInfoTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        navigationController?.isNavigationBarHidden = true
        view.addConstrained(subview: navigationBar, top: nil, left: 0, bottom: nil, right: 0)
        navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        navigationBar.backgroundColor = .mainColor
        userInfoTableView.contentInset.top = navigationBar.frame.height + 23
    }
}

extension ProfileViewController: ProfileViewInput {
}


extension ProfileViewController: NavigationBarWithLogoAndActionsDelegate {
    func exitAction() {
        print("exit action")
    }
}
