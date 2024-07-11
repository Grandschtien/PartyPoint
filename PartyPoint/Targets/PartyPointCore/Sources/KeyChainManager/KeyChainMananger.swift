//
//  KeyChainMananger.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 28.12.2022.
//

import Foundation

public protocol KeyChainMananger {
    func save<T>(_ item: T, service: String, account: String) throws where T: Codable 
    func read<T>(service: String, account: String, type: T.Type) -> T? where T: Codable
    func delete(service: String, account: String)
}
