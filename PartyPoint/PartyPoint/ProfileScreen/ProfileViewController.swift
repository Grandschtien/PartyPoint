//
//  ProfileViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import UIKit
import SnapKit

private let TABLE_VIEW_CONTENT_OFFSET: CGFloat = 23
private let TABLE_CONTENT_OFFSET_WHEN_KEYBOARD_SHOWS: CGFloat = 120

final class ProfileViewController: UIViewController {
    
    private lazy var navigationBar: NavigationBarWithLogoAndActions = {
        let nav = NavigationBarWithLogoAndActions(frame: .zero, buttons: [.exit])
        nav.delegate = self
        nav.backgroundColor = Colors.mainColor()
        return nav
    }()
    private lazy var userInfoTableView: UITableView = {
        let table = UITableView()
        table.registerNib(cellType: UserInfoCell.self)
        table.registerCell(cellType: AboutMeCell.self)
        table.backgroundColor = Colors.mainColor()
        table.separatorStyle = .none
        table.isScrollEnabled = false
        return table
    }()
    
    private lazy var userInfoTableAdapter: ProfileTableAdapter = {
        let adapter = ProfileTableAdapter(userInfoTableView)
        return adapter
    }()
    private let output: ProfileViewOutput
    private var insetsToTop: CGFloat?
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenterManager.addObserver(observer: self,
                                              selector: #selector(keyboardWillShow(_:)),
                                              name: UIWindow.keyboardWillShowNotification,
                                              object: nil)
        NotificationCenterManager.addObserver(observer: self,
                                              selector: #selector(keyboardWillHide(_:)),
                                              name: UIWindow.keyboardWillHideNotification,
                                              object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenterManager.removeObserver(observer: self, name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenterManager.removeObserver(observer: self, name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    private func setupUI() {
        view.backgroundColor = Colors.mainColor()
        navigationController?.isNavigationBarHidden = true
        
        view.addSubview(userInfoTableView)
        view.addSubview(navigationBar)
        
        userInfoTableView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        navigationBar.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
 
        userInfoTableView.contentInset.top = navigationBar.frame.height + TABLE_VIEW_CONTENT_OFFSET.scale()
        insetsToTop = navigationBar.frame.height + TABLE_VIEW_CONTENT_OFFSET.scale()
        
        let tapRec = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        userInfoTableView.addGestureRecognizer(tapRec)
    }
    @objc
    func endEditing() {
        view.endEditing(false)
    }
}

extension ProfileViewController: ProfileViewInput {
}


extension ProfileViewController: NavigationBarWithLogoAndActionsDelegate {
    func exitAction() {
        print("exit action")
    }
}
//MARK: Keyboard notifications
extension ProfileViewController {
    @objc
    func keyboardWillShow(_ notification: Notification) {
        if let insetsToTop = insetsToTop,
           insetsToTop - userInfoTableView.contentInset.top == 0 {
            userInfoTableView.contentInset.top -= TABLE_CONTENT_OFFSET_WHEN_KEYBOARD_SHOWS.scale()
            userInfoTableView.isScrollEnabled = true
        }
    }
    @objc
    func keyboardWillHide(_ notification: Notification) {
        if let insetsToTop = insetsToTop,
           insetsToTop - userInfoTableView.contentInset.top != 0 {
            userInfoTableView.contentInset.top += TABLE_CONTENT_OFFSET_WHEN_KEYBOARD_SHOWS.scale()
            userInfoTableView.isScrollEnabled = false
        }
    }
}
