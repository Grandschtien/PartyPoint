//
//  InitialViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import UIKit

final class InitialViewController: UIViewController {
    
    
    
    weak var router: InitilaRouterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.layer.contents = UIImage.concert?.cgImage
        
    }
}

