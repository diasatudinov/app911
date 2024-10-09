//
//  HomeViewModel.swift
//  app911
//
//  Created by Dias Atudinov on 08.10.2024.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var categories: [Category] = []
    
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
}
