//
//  CoffeeOrderManager.swift
//  Daniel_Coffee
//
//  Created by User on 2024-06-11.
//

import SwiftUI

class CoffeeOrder: ObservableObject, Identifiable, Codable {
    var id = UUID()
    var userName: String
    var coffeeType: String
    var coffeeSize: String
    var quantity: Int
    var isCompleted: Bool
    var price: Double {
        switch coffeeSize {
        case "small":
            return 1.97 * Double(quantity)
        case "medium":
            return 2.97 * Double(quantity)
        case "large":
            return 3.97 * Double(quantity)
        default:
            return 0.0
        }
    }
    
    init(userName: String, coffeeType: String, coffeeSize: String, quantity: Int, isCompleted: Bool) {
        self.userName = userName
        self.coffeeType = coffeeType
        self.coffeeSize = coffeeSize
        self.quantity = quantity
        self.isCompleted = isCompleted
    }
}

class OrderList: ObservableObject {
    @Published var orders: [CoffeeOrder] {
        didSet {
            saveToUserDefaults()
        }
    }
    
    init() {
        self.orders = UserDefaults.standard.loadOrders() ?? []
    }
    
    func addOrder(_ order: CoffeeOrder) {
        orders.append(order)
    }
    
    func deleteOrder(at offsets: IndexSet) {
        orders.remove(atOffsets: offsets)
    }
    
    func deleteOrder(_ order: CoffeeOrder) {
        if let index = orders.firstIndex(where: { $0.id == order.id }) {
            orders.remove(at: index)
        }
    }
    
    func markOrderAsCompleted(_ order: CoffeeOrder) {
        if let index = orders.firstIndex(where: { $0.id == order.id }) {
            orders[index].isCompleted = true
        }
    }
    
    private func saveToUserDefaults() {
        if let encodedData = try? JSONEncoder().encode(orders) {
            UserDefaults.standard.set(encodedData, forKey: "coffeeOrders")
        }
    }
}

extension UserDefaults {
    func loadOrders() -> [CoffeeOrder]? {
        if let savedData = data(forKey: "coffeeOrders") {
            if let decodedOrders = try? JSONDecoder().decode([CoffeeOrder].self, from: savedData) {
                return decodedOrders
            }
        }
        return nil
    }
}
