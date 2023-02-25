//
//  ProfileInfo.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 25.02.2023.
//

import Foundation

struct ProfileInfo {
    let name: String
    let surname: String
    let email: String
    let imageUrl: URL?
    
    var fullName: String {
        return name + " " + surname
    }
}
