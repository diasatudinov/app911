//
//  Category.swift
//  app911
//
//  Created by Dias Atudinov on 08.10.2024.
//

import Foundation

struct homeModel: Codable {
    var activeEvents: Int
    var totalEvents: Int
    var pastEvents: Int
    var moneySpent: Double
}
struct Category: Hashable, Codable {
    var id = UUID()
    var name: String
    var events: [Event]
}

struct Event: Hashable, Codable {
    var id = UUID()
    var name: String
    var date: Date
    var location: String
    var status: String
    //var ticket: Ticket
}
