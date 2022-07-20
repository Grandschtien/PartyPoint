//
//  Section.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 15.07.2022.
//

import Foundation

struct Section: Hashable {
    var id = UUID()
    let header: String?
    let items: [Event]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: Section, rhs: Section) -> Bool {
      lhs.id == rhs.id
    }
}
//TODO: For tests
extension Section {
    static var allSections: [Section] {
        
        let events1 = [
            Event(distance: 1, image: "moc", name: "Концерт басты", date: "22.07.2022"),
            Event(distance: 2, image: "moc", name: "Концерт басты", date: "22.07.2022"),
            Event(distance: 3, image: "moc", name: "Концерт басты", date: "22.07.2022"),
            Event(distance: 4, image: "moc", name: "Концерт басты", date: "22.07.2022"),
            Event(distance: 5, image: "moc", name: "Концерт басты", date: "22.07.2022"),
            Event(distance: 6, image: "moc", name: "Концерт басты", date: "22.07.2022"),
            Event(distance: 7, image: "moc", name: "Концерт басты", date: "22.07.2022")
        ]
        let events2 = [
            Event(distance: 8, image: "moc", name: "Концерт басты", date: "22.07.2022"),
            Event(distance: 9, image: "moc", name: "Концерт басты", date: "22.07.2022"),
            Event(distance: 10, image: "moc", name: "Концерт басты", date: "22.07.2022"),
            Event(distance: 11, image: "moc", name: "Концерт басты", date: "22.07.2022"),
            Event(distance: 12, image: "moc", name: "Концерт басты", date: "22.07.2022"),
            Event(distance: 13, image: "moc", name: "Концерт басты", date: "22.07.2022"),
            Event(distance: 14, image: "moc", name: "Концерт басты", date: "22.07.2022")
        ]
        let events3 = [
            Event(distance: 15, image: "moc", name: "Концерт басты", date: "22.07.2022"),
            Event(distance: 16, image: "moc", name: "Концерт басты", date: "22.07.2022"),
            Event(distance: 17, image: "moc", name: "Концерт басты", date: "22.07.2022"),
            Event(distance: 18, image: "moc", name: "Концерт басты", date: "22.07.2022"),
            Event(distance: 19, image: "moc", name: "Концерт басты", date: "22.07.2022"),
            Event(distance: 20, image: "moc", name: "Концерт басты", date: "22.07.2022"),
            Event(distance: 21, image: "moc", name: "Концерт басты", date: "22.07.2022")
        ]
        
        return [
            Section(header: "Сегодня", items: events1),
            Section(header: "Ближайшие к вам", items: events2),
            Section(header: "Главное", items: events3)
        ]
    }
}
