//
//  EventsInteractor.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import Foundation

final class EventsInteractor {
	weak var output: EventsInteractorOutput?
}

extension EventsInteractor: EventsInteractorInput {
}
