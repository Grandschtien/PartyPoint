//
//  DecoderImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 26.12.2022.
//

import Foundation

final class PPDecoderImpl: PPDecoder {
    func parseJSON<T: Decodable>(from data: Data, type: T.Type) -> T? {
        return try! JSONDecoder().decode(T.self, from: data)
    }
}
