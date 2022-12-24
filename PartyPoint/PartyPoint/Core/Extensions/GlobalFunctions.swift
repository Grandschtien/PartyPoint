//
//  GlobalFunctions.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 23.12.2022.
//

import Foundation

func runOnMainThread(code: EmptyClosure) async {
    await MainActor.run{
        code()
    }
}
