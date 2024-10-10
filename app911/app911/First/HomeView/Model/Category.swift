//
//  Category.swift
//  app911
//
//  Created by Dias Atudinov on 08.10.2024.
//

import SwiftUI

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
    var ticket: Ticket?
    var isArchive: Bool {
        get {
            let currentDate = Date()
            let calendar = Calendar.current
            let orderDateTime = calendar.date(bySettingHour: calendar.component(.hour, from: date),
                                              minute: calendar.component(.minute, from: date),
                                              second: 0, of: date) ?? date
            return orderDateTime < currentDate
        }
    }
}

struct Ticket: Hashable, Codable {
    var id = UUID()
    var imageData: Data?
    var name: String
    var date: String
    var location: String
    var rowPosition: String
    var price: String
    
    var image: UIImage? {
        get {
            guard let data = imageData else { return nil }
            return UIImage(data: data)
        }
        set {
            imageData = newValue?.jpegData(compressionQuality: 1.0)
        }
    }
}
