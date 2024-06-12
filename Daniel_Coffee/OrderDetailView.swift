import SwiftUI

struct OrderDetailView: View {
    var order: CoffeeOrder
    @ObservedObject var orderList: OrderList
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Image(order.coffeeType)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .clipped()
                .cornerRadius(10)
                .padding()

            Text("User: \(order.userName)")
                .font(.headline)
            Text("Coffee Type: \(order.coffeeType)")
            Text("Size: \(order.coffeeSize)")
            Text("Quantity: \(order.quantity)")
            Text("Price: \(order.price, specifier: "%.2f")")
            Text("Completed: \(order.isCompleted ? "Yes" : "No")")

            Button("Mark as Completed") {
                orderList.markOrderAsCompleted(order)
                presentationMode.wrappedValue.dismiss()
            }
            .disabled(order.isCompleted)
            .padding()
            
            Button("Delete Order") {
                orderList.deleteOrder(order)
                presentationMode.wrappedValue.dismiss()
            }
            .foregroundColor(.red)
        }
        .navigationTitle("Order Details")
        .padding()
    }
}

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailView(order: CoffeeOrder(userName: "Daniel", coffeeType: "Latte", coffeeSize: "medium", quantity: 2, isCompleted: false), orderList: OrderList())
    }
}
//Welcome to the order details page
