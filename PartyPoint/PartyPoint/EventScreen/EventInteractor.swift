//
//  EventInteractor.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 16.08.2022.
//  
//

import Foundation

final class EventInteractor {
	weak var output: EventInteractorOutput?
}

extension EventInteractor: EventInteractorInput {
}
