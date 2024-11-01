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
        loadTasks()
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
    
    @Published var tasks: [Task] = [Task(name: "Concert", location: "The Pavilion At Toyota Music Factory", date: Date(), description: "Go to an event concert with 10 friends. Buy tickets in advance and arrange transportation to the venue."),
                                    Task(name: "Concert", location: "The Pavilion At Toyota Music Factory", date: Date(), description: "Go to an event concert with 10 friends. Buy tickets in advance and arrange transportation to the venue."),
                                    Task(name: "Concert", location: "The Pavilion At Toyota Music Factory", date: Date(), description: "Go to an event concert with 10 friends. Buy tickets in advance and arrange transportation to the venue.")]
    {
        didSet {
            saveTasks()
        }
    }
    
    private let tasksFileName = "tasks.json"
    
    private func tasksFilePath() -> URL {
        return getDocumentsDirectory().appendingPathComponent(tasksFileName)
    }
    
   
    
    private func saveTasks() {
        DispatchQueue.global().async {
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(self.tasks)
                try data.write(to: self.tasksFilePath())
            } catch {
                print("Failed to save players: \(error.localizedDescription)")
            }
        }
    }
    
    
    private func loadTasks() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: tasksFilePath())
            tasks = try decoder.decode([Task].self, from: data)
        } catch {
            print("Failed to load players: \(error.localizedDescription)")
        }
    }
    
    func addTask(_ task: Task) {
        tasks.append(task)
    }
    
    func deleteTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: index)
        }
    }
    
    func editTask(_ task: Task, name: String, date: Date, location: String, description: String) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].name = name
            tasks[index].date = date
            tasks[index].location = location
            tasks[index].description = description
        }
    }
    
    // MARK: Discounts
    
    @Published var discounts: [Discount] = [Discount(name: "Super Saturday", description: "Every Saturday, get 20% off all items in the shop. Hurry up, the offer is valid for one day only!")]
    {
        didSet {
            saveDiscounts()
        }
    }
    
    private let discountsFileName = "discounts.json"
    
    private func discountsFilePath() -> URL {
        return getDocumentsDirectory().appendingPathComponent(discountsFileName)
    }
    
    private func saveDiscounts() {
        DispatchQueue.global().async {
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(self.discounts)
                try data.write(to: self.discountsFilePath())
            } catch {
                print("Failed to save players: \(error.localizedDescription)")
            }
        }
    }
    
    
    private func loadDiscounts() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: discountsFilePath())
            discounts = try decoder.decode([Discount].self, from: data)
        } catch {
            print("Failed to load players: \(error.localizedDescription)")
        }
    }
    
    func toggleArchive(_ discount: Discount) {
        if let index = discounts.firstIndex(where: { $0.id == discount.id }){
            discounts[index].isArchive = true
        }
    }
    
    func addDiscount(_ discount: Discount) {
        discounts.append(discount)
    }
}
