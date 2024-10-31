//
//  HomeViewModel.swift
//  app911
//
//  Created by Dias Atudinov on 08.10.2024.
//

import SwiftUI
import StoreKit

class HomeViewModel: ObservableObject {
    @Published var categories: [Category] = []
    {
        didSet {
            savePlaces()
        }
    }
    
    private let placesFileName = "categories.json"
    
    init() {
        loadPlaces()
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func placesFilePath() -> URL {
        return getDocumentsDirectory().appendingPathComponent(placesFileName)
    }
    
   
    
    private func savePlaces() {
        DispatchQueue.global().async {
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(self.categories)
                try data.write(to: self.placesFilePath())
            } catch {
                print("Failed to save players: \(error.localizedDescription)")
            }
        }
    }
    
    
    private func loadPlaces() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: placesFilePath())
            categories = try decoder.decode([Category].self, from: data)
        } catch {
            print("Failed to load players: \(error.localizedDescription)")
        }
    }
    
    @Published var activeEvent = 0
    @Published var totalEvent = 0
    @Published var pastEvent = 0
    @Published var moneySpent = 0.0
    
    func addCategory(_ category: Category) {
        categories.append(category)
    }
    
    func deleteCategory(_ category: Category) {
        if let index = categories.firstIndex(where: { $0.id == category.id }) {
            categories.remove(at: index)
        }
    }
    
    func editCategory(_ category: Category, name: String) {
        if let index = categories.firstIndex(where: { $0.id == category.id }) {
            categories[index].name = name
        }
    }
    
    func editActiveEvent(_ active: Int) {
        activeEvent = active
    }
    
    func editTotalEvent(_ total: Int) {
        totalEvent = total
    }
    
    func editPastEvent(_ past: Int) {
        pastEvent = past
    }
    
    func editMoneySpent(_ money: Double) {
        moneySpent = money
    }
    
    // MARK: - Events
    
    func addEvent(_ category: Category, _ event: Event) {
        if let index = categories.firstIndex(where: { $0.id == category.id }) {
            categories[index].events.append(event)
        }
    }
    
    func editEvent(_ category: Category, _ event: Event, name: String, date: Date, location: String, status: String) {
        if let index = categories.firstIndex(where: { $0.id == category.id }) {
            if let eventIndex = categories[index].events.firstIndex(where: { $0.id == event.id }) {
                categories[index].events[eventIndex].name = name
                categories[index].events[eventIndex].date = date
                categories[index].events[eventIndex].location = location
                categories[index].events[eventIndex].status = status
            }
        }
    }
    
    func createTicket(_ category: Category, _ event: Event, _ ticket: Ticket) {
        if let index = categories.firstIndex(where: { $0.id == category.id }) {
            if let eventIndex = categories[index].events.firstIndex(where: { $0.id == event.id }) {
                categories[index].events[eventIndex].ticket = ticket
            }
        }
    }
    
    func deleteTicket(_ category: Category, _ event: Event) {
        if let index = categories.firstIndex(where: { $0.id == category.id }) {
            if let eventIndex = categories[index].events.firstIndex(where: { $0.id == event.id }) {
                categories[index].events[eventIndex].ticket = nil
            }
        }
    }
    
    func editTicket(_ category: Category, _ event: Event, image: UIImage?, name: String, date: String, location: String, position: String, price: String) {
        if let index = categories.firstIndex(where: { $0.id == category.id }) {
            if let eventIndex = categories[index].events.firstIndex(where: { $0.id == event.id }) {
                categories[index].events[eventIndex].ticket?.image = image
                categories[index].events[eventIndex].ticket?.name = name
                categories[index].events[eventIndex].ticket?.date = date
                categories[index].events[eventIndex].ticket?.location = location
                categories[index].events[eventIndex].ticket?.rowPosition = position
                categories[index].events[eventIndex].ticket?.price = price
            }
        }
    }
    
    func getTicket(_ category: Category, _ event: Event) -> Ticket? {
        if let index = categories.firstIndex(where: { $0.id == category.id }) {
            if let eventIndex = categories[index].events.firstIndex(where: { $0.id == event.id }) {
                return categories[index].events[eventIndex].ticket
            }
        }
        return nil
    }
    
    // MARK: - Settings
    
    func shareApp() {
        guard let url = URL(string: "https://itunes.apple.com/app/id6737277432") else { return }
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(activityVC, animated: true, completion: nil)
        }
    }
    
    func rateApp() {
        SKStoreReviewController.requestReview()
    }
    
    func openUsagePolicy() {
        guard let url = URL(string: "https://www.termsfeed.com/live/bea1d41e-d427-40cf-8ad3-e4cb19caca32") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    // MARK: Event
    
    @Published var tasks: [String] = []
}
