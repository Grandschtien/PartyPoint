//
//  FavouritesViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import UIKit

final class FavouritesViewController: UIViewController {
	private let output: FavouritesViewOutput

    init(output: FavouritesViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension FavouritesViewController: FavouritesViewInput {
}
