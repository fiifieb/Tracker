//
//  Models.swift
//  Tracker iOS
//
//  Created by Fiifi Botchway on 7/19/24.
//

import Foundation
struct User: Decodable {
    let id: Int
    let username: String
    let email: String
}

struct Transaction: Decodable, Identifiable {
    let id: Int
    let userId: Int
    let description: String
    let amount: Double
    let date: String
    let category: String
}
