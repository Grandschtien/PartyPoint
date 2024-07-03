//
//  DecoderImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 26.12.2022.
//

import Foundation

final class PPDecoderImpl: PPDecoder {
    func parseJSON<T: Decodable>(from data: Data, type: T.Type) -> T? {
        debugPrint(try? JSONSerialization.jsonObject(with: data))
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
