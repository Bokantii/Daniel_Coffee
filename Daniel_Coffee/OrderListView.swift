//
//  OrderListView.swift
//  Daniel_Coffee
//
//  Created by User on 2024-06-11.
//
import SwiftUI

struct OrderListView: View {
    @ObservedObject var orderList = OrderList()

    var body: some View {
        NavigationView {
            List {
                ForEach(orderList.orders) { order in
                    NavigationLink(destination: OrderDetailView(order: order, orderList: orderList)) {
                        HStack {
                            Image(order.coffeeType)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .shadow(radius: 5)
                            
                            VStack(alignment: .leading) {
                                Text(order.userName).font(.headline)
                                Text(order.coffeeType).font(.subheadline)
                            }
                            Spacer()
                            Text(order.coffeeSize)
                            Text("Qty: \(order.quantity)")
                        }
                    }
                }
                .onDelete(perform: orderList.deleteOrder)
            }
            .navigationTitle("Daniel")
            .navigationBarItems(trailing: NavigationLink(destination: NewOrderView(orderList: orderList)) {
                Text("New Order")
            })
        }
    }
}

struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView()
    }
}
