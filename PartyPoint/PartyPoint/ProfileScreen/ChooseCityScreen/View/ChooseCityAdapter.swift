//
//  ChooseCityAdapter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 09.05.2023.
//

import UIKit

final class ChooseCityAdapter: NSObject {
    
    enum Cities: String, CaseIterable {
        case msk
        case spb
        case nnv
        case kzn
        case ekb
        case nsk
        
        var fullName: String {
            switch self {
            case .msk:
                return Localizable.msk()
            case .spb:
                return Localizable.spb()
            case .nnv:
                return Localizable.nn()
            case .kzn:
                return Localizable.kaz()
            case .ekb:
                return Localizable.ekb()
            case .nsk:
                return Localizable.nsk()
            }
        }
    }
    
    private var chooseCityAction: ((String) -> Void)?
    
    private weak var tableView: UITableView?
    private var cities: [Cities] = Cities.allCases
    private var chosenCity: Cities?
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
    }
    
    func setChosenCity(city: String) {
        chosenCity = Cities(rawValue: city)
    }
    
    func setChooseCityAction(_ action: @escaping (String) -> Void) {
        self.chooseCityAction = action
    }
}

extension ChooseCityAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellType: CityCell.self, for: indexPath)
        
        let city = cities[indexPath.row]
        cell.configure(city: city.fullName, isSelected: city == chosenCity)
        return cell
    }
}

extension ChooseCityAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chosenCity = cities[indexPath.row]
        
        self.chosenCity = chosenCity
        tableView.reloadData()

        chooseCityAction?(chosenCity.rawValue)
    }
}
