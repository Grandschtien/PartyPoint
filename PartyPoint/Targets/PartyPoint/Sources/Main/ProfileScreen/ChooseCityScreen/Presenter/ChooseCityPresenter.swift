//
//  ChooseCityPresenter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 08.05.2023.
//  
//

import Foundation

protocol ChooseCityPresenter: AnyObject {
    func viewDidLoad()
    func confirmChose()
    func updateChosenCity(city: String)
}

