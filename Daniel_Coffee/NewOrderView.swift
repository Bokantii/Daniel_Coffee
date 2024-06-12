//
//  NewOrderView.swift
//  Daniel_Coffee
//
//  Created by User on 2024-06-11.
//

import SwiftUI

struct NewOrderView: View {
    @ObservedObject var orderList: OrderList
    
    @State private var userName = ""
    @State private var coffeeType = "Affogato"
    @State private var coffeeSize = "small"
    @State private var quantity = 1
    @State private var isCompleted = false

    let coffeeTypes = [
        "Affogato", "Americano", "Cafe au lait", "Capuccino", "Cold Brew",
        "Cortado", "Espresso", "Flat White", "Latte", "Lungo",
        "Machiato", "Mocha", "Nitro Coffee", "Ristretto", "Turkish Coffee"
    ]
    let coffeeSizes = ["small", "medium", "large"]

    var body: some View {
        Form {
            Section(header: Text("Customer Information")) {
                TextField("User Name", text: $userName)
            }
            
            Section(header: Text("Coffee Details")) {
                Picker("Coffee Type", selection: $coffeeType) {
                    ForEach(coffeeTypes, id: \.self) {
                        Text($0)
                    }
                }
                
                Picker("Coffee Size", selection: $coffeeSize) {
                    ForEach(coffeeSizes, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Stepper(value: $quantity, in: 1...20) {
                    Text("Quantity: \(quantity) cups")
                }
                
                Toggle(isOn: $isCompleted) {
                    Text("Order Completed")
                }
            }
            
            Button("Add Order") {
                // Print statements for debugging
                print("User Name: \(userName)")
                print("Coffee Type: \(coffeeType)")
                print("Coffee Size: \(coffeeSize)")
                print("Quantity: \(quantity)")
                print("Is Completed: \(isCompleted)")

                let newOrder = CoffeeOrder(userName: userName, coffeeType: coffeeType, coffeeSize: coffeeSize, quantity: quantity, isCompleted: isCompleted)
                orderList.addOrder(newOrder)
            }
        }
        .navigationTitle("New Order")
    }
}

struct NewOrderView_Previews: PreviewProvider {
    static var previews: some View {
        NewOrderView(orderList: OrderList())
    }
}
