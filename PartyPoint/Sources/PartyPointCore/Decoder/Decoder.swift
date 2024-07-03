//
//  Decoder.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 26.12.2022.
//

import Foundation

protocol PPDecoder {
    func parseJSON<T: Decodable>(from data: Data, type : T.Type) -> T?
}
