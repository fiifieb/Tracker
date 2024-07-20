//
//  TransactionsView.swift
//  Tracker iOS
//
//  Created by Fiifi Botchway on 7/19/24.
//


import SwiftUI

struct TransactionsView: View {
    @State private var transactions: [Transaction] = []
    let userId: Int
    
    var body: some View {
        List(transactions) { transaction in
            VStack(alignment: .leading) {
                Text(transaction.description)
                Text("$\(transaction.amount, specifier: "%.2f")")
                Text(transaction.date)
                Text(transaction.category)
            }
        }
        .onAppear {
            NetworkManager.shared.fetchTransactions(userId: userId) { result in
                switch result {
                case .success(let transactions):
                    self.transactions = transactions
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView(userId: 1)
    }
}
