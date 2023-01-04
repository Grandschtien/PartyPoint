//
//  PhotoManager.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 04.01.2023.
//

import Foundation

final class PhotoManager {
    static func loadPhoto(url: URL?) async throws -> Data {
        guard let url = url else {
            throw URLError(.badURL)
        }
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse else {
            throw URLError(.notConnectedToInternet)
        }
        
        guard response.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return data
    }
}
